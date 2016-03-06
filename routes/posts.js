"use strict";
//просто что бы видеть, какие модули используются
["http", "fs", "pg", "url", "mustache", "querystring", "./bike", "./config"].forEach(cV => require(cV));

var app = require("express")();
//var http = require("http");
var fs = require("fs");
var fw = require("./bike");
var cookies = require("cookie-parser");

var patterns = {
    posts:  fs.readFileSync("./tpl/posts.tpl", "utf-8")
   ,footer: fs.readFileSync("./tpl/footer.tpl", "utf-8")
};

app.use(fw.prepare_headers)
   .use(cookies())
   .use(fw.start_session)
   .get("/add/", function(req, res){
       //просто выводим форму редактора статьи
       //TODO если пользователь не авторизован - предложить авторизоваться или зарегистрироваться
       var mustache = require("mustache");
       var data = {};
       "user" in req && (data.user = req.user);
       res.status(200)
          .send(mustache.render(patterns.posts, data, patterns))
          .end();
    })
.listen(7505, "localhost", undefined,() => console.log('posts.server running at http://localhost:7505'));
