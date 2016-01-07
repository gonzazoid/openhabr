"use strict";
//просто что бы видеть, какие модули используются
["http", "fs", "pg", "url", "mustache", "querystring", "js-sha3", "./bike", "./config"].forEach(cV => require(cV));

var fs = require("fs");
var http = require("http");

var patterns = {
    posts:  fs.readFileSync("./tpl/posts.tpl", "utf-8")
   ,footer: fs.readFileSync("./tpl/footer.tpl", "utf-8")
};

var dispatcher = function(request, response){

    var fw = require("./bike");

         fw.prepare_headers({request, response})
   .then(fw.parse_post, fw.error)
   .then(fw.parse_cookies, fw.err)
   .then(fw.start_session, fw.err)
   .then(worker, fw.err)
   .then(fw.output, fw.err);
};
var worker = function(request, response){
    
    //проверим action
    //если newuser - пришли данные на регистрацию
    console.log(request.post);
    switch(job.request.url){
        case "/add/":
            //просто выводим форму редактора статьи
            //TODO если пользователь не авторизован - предложить авторизоваться или зарегистрироваться
            "data" in job.response.habr || (job.response.habr.data = {});
            job.response.habr.pattern = patterns.post;
            job.response.habr.patterns = patterns;
            resolve(job);

            break;
        default:
            
    }
};

http.createServer(starter).listen(7505, "localhost");
console.log('users.server running at http://localhost:7505');
