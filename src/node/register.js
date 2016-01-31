"use strict";
//просто что бы видеть, какие модули используются
["http", "fs", "pg", "url", "mustache", "js-sha3", "validator", "querystring", "./bike", "./config"].forEach(cV => require(cV));
var express = require("express");
var app = express();
var fs = require("fs");
var fw = require("./bike");
//var http = require("http");
var cookies = require("cookie-parser");
var bodyParser = require("body-parser");


var patterns = {
    register       : fs.readFileSync("./tpl/register.tpl", "utf-8")
   ,footer         : fs.readFileSync("./tpl/footer.tpl", "utf-8")
   ,congratulations: fs.readFileSync("./tpl/congratulations.tpl", "utf-8")
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
   .use(bodyParser.urlencoded({extended:true}))
   .get("/", function(req, res){
       var mustache = require("mustache");
       var data = {};
       "user" in req && (data.user = req.user);
       res.status(200)
          .send(mustache.render(patterns.register, data, patterns))
          .end();
   })
   .post("/newuser", function(req, res){
       var pg = require("pg");
       var config = require("./config");
       var sha3 = require("js-sha3").sha3_512;
       var validator = require("validator");
       //регистрируем новичка
       console.log(req.body);
       var rules = {
             "nickname" : {"flags": "required", "type": "string"}
            ,"sword"    : {"flags": "required", "type": "string"}
            ,"mailbox"  : {"flags": "required", "type": "string"}
       };
       try {
           req.post = validator(req.body, rules);
       } catch (err) {
           console.log("register: bad request:\nuser:\n", req.user, "\npost:\n", req.body, "\nerror\n", err);
           res.sendStatus(500)
	      .end();
           return;
       }
       pg.connect(config.common.postgres, function (err, pgClient, done) {
           if(err){
               console.log(err);
               res.sendStatus(500)
	          .end();
               return;
           }
           var sql = "select * from adduser($1, $2, $3, $4);"
           var sid = rndHex(128);
           pgClient.query({
               text: sql
              ,values: [req.post.nickname, req.post.mailbox, sha3(req.post.sword), sid]
           }, function(err, result){
               done();
               if(err){
                   res.sendStatus(500)
                      .end();
                   return;
               }
               console.log(result);
	       // если все хорошо - выставляем куки и поздравляем с регистрацией
               var data = {};
               if(result.rows[0].adduser){
                   //куки авторизации
                   res.set("Set-Cookie", 'id=' + sid + '; path=/; HttpOnly;');
                   data.user = {nickname: req.post.nickname};
                   res.status(200)
                      .send(mustache.render(patterns.congratulations, data, patterns))
                      .end();
               }else{//что то пошло не так - просим повторить заново (логин либо почта уже есть в системе)
                   res.status(200)
                      .send(mustache.render(patterns.register, data, patterns))
                      .end();
               }
           });
       });
   })
.listen(7502, "localhost", undefined, () => console.log('views.server running at http://localhost:7502'));
