import pg     from 'pg-then';
import config from '../config';
import as     from 'async';

const data = {
  partials: {
    footer: 'footer'
  }
};

const pool = pg.Pool(config.postgresURL);
const sql = 'SELECT V.*, M.hub_title, M.hub_id, M.hub_name, users.nickname FROM (SELECT I.id, I.stamp, array_agg(J.title) as hub_title, array_agg(J.id) as hub_id, array_agg(J.name) as hub_name FROM (SELECT * FROM articles WHERE draft = false ORDER BY stamp DESC LIMIT 10) I, hubs J WHERE  J.id = ANY(I.hubs) GROUP BY I.id, I.stamp, I.hubs ORDER BY I.stamp DESC) M, articles V, users WHERE M.id = V.id AND V.author = users.id ORDER BY stamp DESC;';

pool
  .query(sql)
  .then(result => {
    // сольем вместе hub_title, id и name
    as.each(result.rows, (item, callback) => {
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
      callback();
    }, err => {
      if (err) {
        console.error(err);
      } else {
        data.articles = result.rows;
      }
    });
  })
  .catch(err => {
    console.error(err);
  });

export default (req, res) => {
  data.user = req.session.user ? req.session.user : {};
  res.render('all', data);
};
