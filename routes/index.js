import { Router } from 'express';
const router = new Router();

import All from './all';
import Posts from './posts';
import Auth from './auth';

router.route('/').get(All);
router.route('/post').get();
router.route('/register').get();
router.route('/users').get();
router.route('/auth').get();
router.route('/posts').get();
router.route('/add').get(Posts);
router.route('/logout').get(Auth);
router.route('/json').get();

export default router;
