"use strict";
//просто что бы видеть, какие модули используются
["http", "fs", "pg", "querystring", "url", "mustache", "validator", "js-sha3", "./bike", "./config"].forEach(cV => require(cV));

var app = require("express")();
//var http = require("http");
var fs = require("fs");
var fw = require("./bike");
var cookies = require("cookie-parser");
var bodyParser = require("body-parser");

var patterns = {
    auth    : fs.readFileSync("./tpl/auth.tpl", "utf-8")
   ,settings: fs.readFileSync("./tpl/settings.tpl", "utf-8")
   ,footer  : fs.readFileSync("./tpl/footer.tpl", "utf-8")
};

var rndHex = function (len) {
    var id = '';
    var map = '0123456789abcdef';

    for (var $i = 0; $i < len; $i++) {
        id += map.charAt(Math.floor(Math.random() * 16));
    }

    return id;
};

app.use(fw.prepare_headers)
   .use(cookies())
   .use(fw.start_session)
   .use(bodyParser.json())
   .post("/auth/login/", function(req, res){
//{{{
       var pg = require("pg");
       var config = require("./config");
       var sha3 = require("js-sha3").sha3_512;
       var url = require("url");
       var validator = require("validator");
       console.log("/login/");
       //отфильтруем данные - тоже кандидат на вынос в общий поток обработки
       var rules = {
           "nickname" : {"flags": "required", "type": "string"}
          ,"sword"    : {"flags": "required", "type": "string"}
          ,"return"   : {"flags": "required", "type": "string"}
          ,"submit"   : {"type": "string"}
       };
       try {
           req.post = validator(req.body, rules);
       } catch (err) {
       console.log("bad request:\nuser:\n", req.user, "\npost:\n", req.body, "\nerror\n", err);
           reject();
           return;
       }
       pg.connect(config.common.postgres, function (err, pgClient, done) {
           if(err){
               console.log(err);
               res.sendStatus(500)
		  .end();
               return;
           }
           var sql = "select * from auth($1, $2, $3);";
           pgClient.query({
               text: sql
              ,values: [req.post.nickname, sha3(req.post.sword), rndHex(128)]
           }, function(err, result){
               done();
               if(err){
                   console.log(err);
                   res.sendStatus(500)
		      .end();
                   return;
               }
               console.log(result.rows);
               //здесь и выводим
               if(result.rows.length != 1){
               //что то пошло не так
               }
               //response.user = result.rows[0];
               if("return" in req.post){
                   var parsed = url.parse(req.post.return);
                   res.set("Location", parsed.hostname == "openhabr.net" ? req.post.return : "/");
               }else{
                   res.set("Location", "/");
               }
               res.set("Set-Cookie", 'id=' + result.rows[0].sid + '; path=/; HttpOnly;');
               res.sendStatus(303)
	          .end();
           });
       });
//}}}
   })
   .get("/logout/", function(req, res){
//{{{
       var pg = require("pg");
       var config = require("./config");
       var url = require("url");
       if("user" in req){
           pg.connect(config.common.postgres, function (err, pgClient, done) {
	       if(err){
                   console.log(err);
                   fw.err(res);
    	           return;
	       }
               var sql = "select * from reset_session($1);";
               pgClient.query({
                   text: sql
	          ,values: [req.user.id]
	       }, function(err, result){
                   done();
               });
           });
       }
       res.set("Set-Cookie", 'id=; path=/; HttpOnly;');
       if("referer" in req.headers){
           var parsed = url.parse(req.headers.referer);
           res.set("Location", parsed.hostname == "openhabr.net" ? req.headers.referer : "/");
       }else{
           res.set("Location", "/");
       }
       res.sendStatus(303)
          .end();
//}}}
   })
   .get("/", function(req, res){
//{{{
       var pg = require("pg");
       var config = require("./config");
       var mustache = require("mustache");
       //проверим action
       //если newuser - пришли данные на регистрацию
       console.log(req.body);
       console.log(req.url);
       //если нет никаких данных - просто выводим форму авторизации
       //TODO  тут вообще то если пользователь уже авторизован - надо бы ему сообщать об этом
       var data = {};
       data.return = "referer" in req.headers ? req.headers.referer : "/";
       "user" in req && (data.user = req.user);
       res.status(200)
          .send(mustache.render(patterns.settings, data, patterns))
          .end();
//}}}
   })
   .get("/settings/", function(req, res){
       var mustache = require("mustache");
       var data = {};
       "user" in req && (data.user = req.user);
       res.status(200)
          .send(mustache.render(patterns.settings, data, patterns))
          .end();
   })
.listen(7504, "localhost", undefined,() => console.log('auth.server running at http://localhost:7504'));
