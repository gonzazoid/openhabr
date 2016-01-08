"use strict";
//просто что бы видеть, какие модули используются
["http", "fs", "pg", "querystring", "url", "mustache", "js-sha3", "./bike", "./config"].forEach(cV => require(cV));

var http = require("http");
var fs = require("fs");

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

var dispatcher = function(request, response){

    var fw = require("./bike");

         fw.prepare_headers({request, response})
   .then(fw.parse_post, fw.error)
   .then(fw.parse_cookies, fw.err)
   .then(fw.start_session, fw.err)
   .then(worker, fw.err)
   .then(fw.output, fw.err);
};

var worker = function(job){
    return new Promise(function(resolve, reject){
        var pg = require("pg");
        var config = require("./config");
        var sha3 = require("js-sha3").sha3_512;
        var url = require("url");
        var validator = require("validator");
        //проверим action
        //если newuser - пришли данные на регистрацию
        console.log(job.request.post);
        console.log(job.request.url);
        switch(job.request.url){
            case "/":
                //если нет никаких данных - просто выводим форму авторизации
                //TODO  тут вообще то если пользователь уже авторизован - надо бы ему сообщать об этом
                "data" in job.response.habr || (job.response.habr.data = {});
                job.response.habr.data.return = "referer" in job.request.headers ? job.request.headers.referer : "/";
                job.response.habr.pattern = patterns.auth;
                job.response.habr.patterns = patterns;
                resolve(job);
                break;
            case "/auth/login/":
                console.log("/login/");
                //отфильтруем данные - тоже кандидат на вынос в общий поток обработки
                var rules = {
                     "nickname" : {"flags": "required", "type": "string"}
                    ,"sword"    : {"flags": "required", "type": "string"}
                    ,"return"   : {"flags": "required", "type": "string"}
                    ,"submit"   : {"type": "string"}
                };
                try {
                    job.request.post = validator(job.request.post, rules);
                } catch (err) {
	            console.log("bad request:\nuser:\n", job.request.user, "\npost:\n", job.request.post, "\nerror\n", err);
                    reject();
	            return;
                }
                pg.connect(config.common.postgres, function (err, pgClient, done) {
	            if(err){
                        console.log(err);
                        reject();
    	                return;
	            }
                    var sql = "select * from auth($1, $2, $3);";
                    pgClient.query({
                        text: sql
	               ,values: [job.request.post.nickname, sha3(job.request.post.sword), rndHex(128)]
	            }, function(err, result){
                        done();
	                if(err){
                            console.log(err);
                            reject();
    	                    return;
	                }
                        console.log(result.rows);
                        //здесь и выводим
                        if(result.rows.length != 1){
                            //что то пошло не так
                        }
                        //response.user = result.rows[0];
                        if("return" in job.request.post){
                            var parsed = url.parse(job.request.post.return);
                            job.response.habr.headers["Location"] = parsed.hostname == "openhabr.net" ? job.request.post.return : "/"
                        }else{
                            job.response.habr.headers["Location"] = "/";
                        }
                        job.response.habr.headers["Set-Cookie"] = 'id=' + result.rows[0].sid + '; path=/; HttpOnly;';
                        job.response.habr.status = {code: 303, message: "See Other"};
                        resolve(job);
                    });
                });
                break;
            case "/logout/":
                if("user" in job.request){
                    pg.connect(config.common.postgres, function (err, pgClient, done) {
	                if(err){
                            console.log(err);
                            reject();
    	                    return;
	                }
                        var sql = "select * from reset_session($1);";
                        pgClient.query({
                            text: sql
	                   ,values: [job.request.user.id]
	                }, function(err, result){
                            done();
                        });
                    });
                }
                job.response.habr.headers["Set-Cookie"] = 'id=; path=/; HttpOnly;';
                //console.log(request.headers);
                if("referer" in job.request.headers){
                    var parsed = url.parse(job.request.headers.referer);
                    job.response.habr.headers["Location"] = parsed.hostname == "openhabr.net" ? job.request.headers.referer : "/"
                }else{
                    job.response.habr.headers["Location"] = "/";
                }
                job.response.habr.status = {code: 303, message: "See Other"};
                resolve(job);
                break;
            case "/settings/":
                "data" in job.response.habr || (job.response.habr.data = {});
                job.response.habr.pattern = patterns.settings;
                job.response.habr.patterns = patterns;
                resolve(job);
                break;
        }
    });
};

http.createServer(dispatcher).listen(7504, "localhost");
console.log('auth.server running at http://localhost:7504');
