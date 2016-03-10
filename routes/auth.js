import pg                   from 'pg-then';
import config               from '../config';
import validator            from 'validator';
import { sha3_512 as sha3 } from 'js-sha3';

const data = {};
const rules = {
  nickname: {
    flags: 'required',
    type: 'string'
  },
  sword: {
    flags: 'required',
    type: 'string'
  },
  return: {
    flags: 'required',
    type: 'string'
  },
  submit: {
    type: 'string'
  }
};

const pool = pg.Pool(config.postgresURL);

export function root(req, res) {
  // проверим action
  // если newuser - пришли данные на регистрацию
  console.log(req.body);
  console.log(req.url);
  // если нет никаких данных - просто выводим форму авторизации
  // TODO  тут вообще то если пользователь уже авторизован - надо бы ему сообщать об этом
  res.render('auth', {
    user: req.session.user ? req.session.user : {},
    referer: req.headers.referer ? req.headers.referer : '/',
    partials: {
      footer: 'footer'
    }
  });
}

export function login(req, res) {
  console.log('/login/');
  let post;

  try {
    post = validator(req.body, rules);
  } catch (err) {
    console.error(`
bad request:
user:
${post.nickname}
post:
${req.body}
error
${err}
`);
    res.sendStatus(500).end();
  }

  console.log(post);
  const sql = 'select * from auth($1, $2, $3);';

  pool
    .query({
      text: sql,
      values: [post.nickname, sha3(post.sword), '']
    })
    .then(result => {
      console.log(result.rows);
      // здесь и выводим
      if (result.rows.length !== 1) {
        // что то пошло не так
        // TODO обработать иначе кидает ошибку
        console.log(`
auth failed:
user:
${req.user}
post:
${req.body}
`);
      }
      req.session.user = {
        nickname: post.nickname
      };
      res.redirect(post.return ? post.return : '/');
    })
    .catch(err => {
      console.error(err);
    });

  res.render('posts', {
    user: req.session.user ? req.session.user : {},
    partials: {
      footer: 'footer'
    }
  });
}

export function logout(req, res) {
  req.session.destroy(err => {
    res.redirect('/');
  });
}

export function settings(req, res) {
  res.render('settings', {
    user: req.session.user ? req.session.user : {},
    partials: {
      footer: 'footer'
    }
  });
}
