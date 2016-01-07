"use strict";
//просто что бы видеть, какие модули используются
["http", "fs", "pg", "url", "mustache", "js-sha3", "querystring", "./bike", "./config"].forEach(cV => require(cV));

var fs = require("fs");
var http = require("http");

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
        //проверим action
        //если newuser - пришли данные на регистрацию
        console.log(job.request.post);
        switch(job.request.url){
            case "/newuser":
                //регистрируем новичка
                console.log(job.request.post);
                pg.connect(config.common.postgres, function (err, pgClient, done) {
	            if(err){
                        console.log(err);
                        reject();
    	                return;
	            }
                    var sql = "select * from adduser($1, $2, $3, $4);"
                    var sid = rndHex(128);
                    pgClient.query({
                        text: sql
	               ,values: [job.request.post.nickname, job.request.post.mailbox, sha3(job.request.post.sword), sid]
	            }, function(err, result){
                        done();
	                if(err){
		            console.log(err);
                            reject();
		            return;
	                }
                        console.log(result);
                        // если все хорошо - выставляем куки и поздравляем с регистрацией
                        "data" in job.response.habr || (job.response.habr.data = {});
                        if(result.rows[0].adduser){
                            //куки авторизации
                            job.response.habr.headers["Set-Cookie"] = 'id=' + sid + '; path=/; HttpOnly;';
                            job.response.habr.data.user = {nickname: job.request.post.nickname};
                            job.response.habr.pattern = patterns.congratulations;
                            job.response.habr.patterns = patterns;
                            resolve(job);

                        }else{//что то пошло не так - просим повторить заново (логин либо почта уже есть в системе)
                            job.response.habr.pattern = patterns.register;
                            job.response.habr.patterns = patterns;
                            resolve(job);
                        }
                    });
                });
                break;
            case "/":
                "data" in job.response.habr || (job.response.habr.data = {});
                job.response.habr.pattern = patterns.register;
                job.response.habr.patterns = patterns;
                resolve(job);
                break;
        }
    });
};

http.createServer(dispatcher).listen(7502, "localhost");
console.log('views.server running at http://localhost:7502');
