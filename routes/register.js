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
  mailbox: {
    flags: 'required',
    type: 'string'
  },
  promo: {
    flags: 'notRequired',
    type: 'string'
  },
  submit: {
    flags: 'notRequired',
    type: 'string'
  }
};

const pool = pg.Pool(config.postgresURL);

export function root(req, res) {
  data.user = req.session.user ? req.session.user : {};
  data.partials = {
    footer: 'footer'
  };
  res.render('register', data);
}

export function newUser(req, res) {
  console.log(req.body);
  let post;

  try {
    post = validator(req.body, rules);
  } catch (err) {
    console.error(`
register: bad request:
user:
${req.user}
post:
${req.body}
error
${err}
`);
    throw new Error(err);
  }

  const sql = 'select * from adduser($1, $2, $3, $4);';

  pool
    .query({
      text: sql,
      values: [post.nickname, post.mailbox, sha3(post.sword), '']
    })
    .then(result => {
      console.log(result);
      data.user = {
        nickname: post.nickname
      };
      data.partials = {
        footer: 'footer'
      };
      if (result.rows[0].adduser) {
        req.session.user = {
          nickname: post.nickname
        };
        res.render('congratulations', data);
      } else {
        // что то пошло не так - просим повторить заново (логин либо почта уже есть в системе)
        res.render('register', data);
      }
    })
    .catch(err => {
      throw new Error(err);
    });
}
