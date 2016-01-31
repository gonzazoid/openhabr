"use strict";
//просто что бы видеть, какие модули используются
["http", "fs", "pg", "url", "mustache", "./bike", "./config"].forEach(cV => require(cV));

var fs = require("fs");
//var http = require("http");
var app = require("express")();
var fw = require("./bike");
var cookies = require("cookie-parser");
var bodyParser = require("body-parser");

var patterns = {

};

app.use(fw.prepare_headers)
   .use(cookies())
   .use(fw.start_session)
   .use(bodyParser.urlencoded({extended:true}))
   .post("/comment/", function(req, res){
        console.log(req);
	req.post = req.body;

        var pg = require("pg");
        var config = require("./config");
       pg.connect(config.common.postgres, function (err, pgClient, done) {
           if(err){
               console.log(err);
               res.sendStatus(500)
	          .end();
               return;
           }
           var sql = "select * from addcomment($1, $2, $3, $4);"
           pgClient.query({
               text: sql
              ,values: [req.user.id, req.post.ti, req.post.parent_id, req.post.text]
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
               if(result.rows[0].addcomment){
                   //куки авторизации
                   //res.set("Set-Cookie", 'id=' + sid + '; path=/; HttpOnly;');
                   //data.user = {nickname: req.post.nickname};
                   res.status(200)
                      .json({"code": 200, "status": "ok"})
                      .end();
               }else{
                   res.status(500)
                      .end();
               }
           });
       });
    })

.listen(7506, "localhost", undefined,() => console.log('comment.server running at http://localhost:7506'));
