import pg        from 'pg-then';
import config    from '../config';

const pool = pg.Pool(config.postgresURL);

export default (req, res) => {
  let sql = 'SELECT articles.*, M.hub_name, M.hub_title, M.hub_id, users.nickname, users.fullname, users.status as u_status, users.carma, users.rating as u_rating FROM articles, (SELECT I.id, array_agg(J.title) as hub_title, array_agg(J.name) as hub_name, array_agg(J.id) as hub_id FROM (SELECT * FROM articles WHERE id = $1 AND draft = false) I, hubs J WHERE J.id = ANY(i.hubs) GROUP BY I.id) M, users WHERE M.id = articles.id AND articles.author = users.id;';

  let article = {};

  pool
    .query({
      text: sql,
      values: [req.params.id]
    })
    .then(result => {
      if (result.rows.length !== 1) {
        // либо статья не найдена либо найдено больше одной статьи (что станно)
      }
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
            // этот код никогда не должен сработать!
            delete(item.hubs[i]);
          }
        }
      });
      article = result.rows[0];
      // если есть комментарии - вытащим их (в дальнейшем надо перевести на queue, пока тянем последовательно
      // ли отрисовку комментов сделать на клиенте? С точки зрения производительности - да, а вот с точки зрения индексации
      // учше все таки комменты отдавать статикой
      // k, сделаем и так и так
      const sql = 'SELECT comments.*, users.nickname FROM comments, users WHERE article_id = $1 AND comments.author = users.id ORDER BY stamp ASC;';
      return pool
        .query({
          text: sql,
          values: [req.params.id]
        });
    }).then(result => {
      // console.log(result.rows);
      // ок, выстроим дерево
      // коммент - объект вида "{id: "", body: "", author: "", comments: []}
      // перенесем все корневые комменты в наш массив
      // создадим объект X где ключ - id коммента, значение - сам коммент
      // пройдемся исходному списку и по reply_to запушим комменты в comments владельца
      // делаем вывод корневых эелементов - имеем построенное дерево, но! пока еще не упорядоченное по stamp-ам
      // хотя есть мысль что если взять изначально отсортированный список (силами sql) - то и результат будет отсортирован
      // var root = result.rows.filter((cv) => cv.reply_to == 0);
      // console.log(root);
      // ok, перекидываем
      const by_id = {
        '0': {
          comments: []
        }
      };
      for (let i = 0, l = result.rows.length; i < l; i++) {
        result.rows[i].comments = [];
        by_id[result.rows[i].id] = result.rows[i];
      }
      // ok, догружаем
      // console.log("comments:", by_id);
      for (let i = 0, l = result.rows.length; i < l; i++) {
        if (result.rows[i].reply_to in by_id) {
          by_id[result.rows[i].reply_to].comments.push(result.rows[i]);
        } else {
          // TODO это не нормально, коммент с каким то кривым предком
        }
      }
      // ok, в by_id['0'] имеем все дерево комментов
      // пробуем рекурсивный шаблон вывода
      article.comments = by_id['0'].comments;
      res.render('article', {
        user: req.session.user ? req.session.user : {},
        article,
        partials: {
          comments: 'comments',
          footer: 'footer'
        }
      });
    })
    .catch(err => {
      console.error(err);
    });
};
