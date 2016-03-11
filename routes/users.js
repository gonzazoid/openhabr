import pg     from 'pg-then';
import config from '../config';

const pool = pg.Pool(config.postgresURL);
const data = {};

export function root(req, res) {
  const sql = 'SELECT * FROM users ORDER BY carma DESC LIMIT 20;';

  pool
    .query(sql)
    .then(result => {
      data.users = result.rows;
      data.partials = {
        footer: 'footer'
      };
      res.render('users', data);
    })
    .catch(err => {
      console.error(err);
    });
}

export function getUser(req, res) {
  const sql = 'SELECT * FROM get_user_by_name($1);';

  pool
    .query({
      text: sql,
      values: [req.params.id]
    })
    .then(result => {
      if (result.rows.length !== 1) {
        // TODO что то пошло не так
      }
      // сольем медальки
      const medals = {};

      for (let i = 0, l = result.rows[0].medals.length; i < l; i++) {
        medals[result.rows[0].medals[i]] = {
          title: result.rows[0].medal_title[i],
          description: result.rows[0].medal_description[i]
        };
      }
      for (let i = 0, l = result.rows[0].medals.length; i < l; i++) {
        result.rows[0].medals[i] = medals[result.rows[0].medals[i]];
      }
      data.user = req.session.user ? req.session.user : {};
      data.profile = result.rows[0];
      data.partials = {
        footer: 'footer'
      };
      res.render('user', data);
    })
    .catch(err => {
      console.error(err);
    });
}

export function getTopics(req, res) {
  const sql = 'SELECT * FROM get_user_by_name($1);';

  pool
    .query({
      text: sql,
      values: [req.params.id]
    })
    .then(result => {
      if (result.rows.length !== 1) {
        // TODO что то пошло не так
      }
      data.profile = result.rows[0];
      const sql = 'SELECT V.*, M.hub_title, M.hub_id, M.hub_name, users.nickname FROM (SELECT I.id, I.stamp, array_agg(J.title) as hub_title, array_agg(J.id) as hub_id, array_agg(J.name) as hub_name FROM (SELECT * FROM articles WHERE draft = false AND author=$1 ORDER BY stamp DESC LIMIT 10) I, hubs J WHERE J.id = ANY(I.hubs) GROUP BY I.id, I.stamp, I.hubs ORDER BY I.stamp DESC) M, articles V, users WHERE M.id = V.id AND V.author = users.id ORDER BY stamp DESC;';
      return pool
        .query({
          text: sql,
          values: [result.rows[0].id]
        });
    })
    .then(result => {
      // сольем вместе hub_title, id и name
      result.rows.forEach((item, key, holder) => {
        const hubs = [];
        if (!item.hubs.length) return;
        for (let i = 0, l = item.hub_id.length; i < l; i++) {
          hubs[item.hub_id[i]] = {
            id: item.hub_id[i],
            name: item.hub_name[i],
            title: item.hub_title[i]
          };
        }
        for (let i = 0, l = item.hubs.length; i < l; i++) {
          if (item.hubs[i] in hubs) {
            item.hubs[i] = hubs[item.hubs[i]];
          } else {
            delete(item.hubs[i]);
          }
        }
      });
      data.articles = result.rows;
      data.user = req.session.user ? req.session.user : {};
      data.partials = {
        footer: 'footer'
      };
      res.render('user_topics', data);
    })
    .catch(err => {
      console.error(err);
    });
}
