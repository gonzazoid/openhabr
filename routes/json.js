import pg                   from 'pg-then';
import config               from '../config';

const pool = pg.Pool(config.postgresURL);

export default (req, res) => {
  const sql = 'select * from addcomment($1, $2, $3, $4);';
  const post = req.body;

  pool
    .query({
      text: sql,
      values: [req.session.user.id, post.ti, post.parent_id, post.text]
    })
    .then(result => {
      console.log(result);
      if (result.rows[0].addcomment) {
        res.json({
          code: 200,
          status: 'ok'
        });
      } else {
        res.sendStatus(500);
      }
    })
    .catch(err => {
      throw new Error(err);
    });
};
