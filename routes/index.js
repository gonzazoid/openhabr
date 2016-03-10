import { Router } from 'express';
const router = new Router();

import * as All   from './all';
import * as Reg   from './register';
import Posts      from './posts';
import Post       from './post';
import Comments   from './json';
import * as Auth  from './auth';
import * as Users from './users';

router.route('/').get(All.redirect);
router.route('/all').get(All.root);
router.route('/post/:id').get(Post);
router.route('/register').get(Reg.root);
router.route('/register/newuser').post(Reg.newUser);
router.route('/users').get(Users.root);
router.route('/users/:id').get(Users.getUser);
router.route('/users/:id/topics').get(Users.getTopics);
router.route('/auth').get(Auth.root);
router.route('/auth/login').post(Auth.login);
router.route('/auth/logout').get(Auth.logout);
router.route('/auth/settings').get(Auth.settings);
router.route('/posts/add').get(Posts);
router.route('/json/comment').post(Comments);

export default router;
