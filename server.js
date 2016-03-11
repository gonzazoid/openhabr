import express      from 'express';
import deb          from 'debug';
import logger       from 'morgan';
import path         from 'path';
import favicon      from 'serve-favicon';
import bodyParser   from 'body-parser';
import pg           from 'pg';
import session      from 'express-session';
import pgS          from 'connect-pg-simple';
import cookieParser from 'cookie-parser';
import cons         from 'consolidate';
import routes       from './routes';
import config       from './config';

const pgSession = pgS(session);
const debug = deb('app');

const app = express();

app.set('port', config.port);

app.engine('tpl', cons.mustache);
app.set('view engine', 'tpl');
app.set('views', `${__dirname}/views`);
if (app.get('env') !== 'development') {
  app.enable('view cache');
} else {
  app.use(logger('dev'));
}
app.set('trust proxy', 1);
app.use(favicon(`${__dirname}/public/favicon.ico`));
app.use(bodyParser.json({
  limit: '20mb'
}));
app.use(bodyParser.urlencoded({
  limit: '20mb',
  extended: true
}));
app.use(cookieParser());
app.use(session({
  store: new pgSession({
    pg,
    conString : config.postgresURL,
    tableName : 'session'
  }),
  secret: config.secret,
  resave: false,
  saveUninitialized: true,
  cookie: {
    httpOnly: true,
    maxAge: 30 * 24 * 60 * 60 * 1000 // 30 days
  }
}));
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', routes);

// catch 404 and forwarding to error handler
app.use((req, res, next) => {
  const err = new Error('Страница не найдена');
  err.status = 404;
  next(err);
});

if (app.get('env') === 'development') {
  // development error handler
  // will print stacktrace
  app.use((err, req, res) => {
    res.status(err.status || 500);
    res.send(err.message);
    // res.render('error', {
    //   message: err.message,
    //   error: err
    // });
  });
} else {
  // production error handler
  // no stacktraces leaked to user
  app.use((err, req, res) => {
    res.status(err.status || 500);
    res.send(err.message);
    // res.render('error', {
    //   message: err.message,
    //   error: {}
    // });
  });
}

app.listen(app.get('port'), config.ip, () => {
  debug(`Express server listening on port ${app.get('port')} in ${app.get('env')} mode`);
});
