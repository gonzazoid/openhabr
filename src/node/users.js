"use strict";
//просто что бы видеть, какие модули используются
["http", "fs", "pg", "querystring", "url", "js-sha3", "mustache", "./bike", "./config"].forEach(cV => require(cV));

var fs = require("fs");
var http = require("http");

var patterns = {
    pattern: fs.readFileSync("./tpl/user.tpl", "utf-8")
   ,footer : fs.readFileSync("./tpl/footer.tpl", "utf-8")
   ,users  : fs.readFileSync("./tpl/users.tpl", "utf-8")
   ,user   : fs.readFileSync("./tpl/user.tpl", "utf-8")
};

var dispatcher = function(request, response){

    var fw = require("./bike");

         fw.prepare_headers({request, response})
   .then(fw.parse_cookies, fw.err)
   .then(fw.start_session, fw.err)
   .then(worker, fw.err)
   .then(fw.output, fw.err);
};

var worker = function(job){
    return new Promise(function(resolve, reject){
        var url = require("url");
        var pg = require("pg");
        var config = require("./config");
        var fw = require("./bike");
        //проверим action
        //если newuser - пришли данные на регистрацию
        console.log(job.request.post);
        switch(job.request.url){
            case "/":
                //если нет никаких данных - просто выводим список пользователей
                pg.connect(config.common.postgres, function (err, pgClient, done) {
	            if(err){
                        console.log(err);
                        reject();
    	                return;
	            }
                    var sql = "SELECT * FROM users ORDER BY carma DESC LIMIT 20;";   
                    pgClient.query({
                        text: sql
	                // ,values: argv
	            }, function(err, result){
                        done();
	                if(err){
		            console.log(err);
                            reject();
		            return;
	                }
 
                        "data" in job.response.habr || (job.response.habr.data = {});
                        job.response.habr.data.users = result.rows;
                        job.response.habr.pattern = patterns.users;
                        job.response.habr.patterns = patterns;
                        resolve(job);
                    });
                });
                break;
            default:
            if(/^\/[a-zA-z0-9_\-]+\/$/.test(request.url)){
                console.log(request.url);
                var res = request.url.split("/");
                console.log(res);
                var nickname = res[1];
                pg.connect(config.common.postgres, function (err, pgClient, done) {
	            if(err){
                        console.log(err);
                        response.end();
    	                return;
	            }
                    var sql = "SELECT * FROM get_user_by_name($1);";   
                    pgClient.query({
                        text: sql
	               ,values: [nickname]
	            }, function(err, result){
                        done();
	                if(err){
		            console.log(err);
                            response.end();
		            return;
	                }   
                        if(result.rows.length != 1){
                            //TODO что то пошло не так
                        }
                        //сольем медальки
                        var medals = {};
                        for(i=0, l=result.rows[0].medals.length; i<l; i++){
                            medals[result.rows[0].medals[i]] = {title:       result.rows[0].medal_title[i]
                                                               ,description: result.rows[0].medal_description[i]};
                        }
                        for(i=0, l=result.rows[0].medals.length; i<l; i++){
                            result.rows[0].medals[i] =  medals[result.rows[0].medals[i]];
                        }
                        var headers = {};

                        headers['Content-Type'] = 'text/html';
                        headers['Expires'] = 'Mon, 26 Jul 1997 05:00:00 GMT'; //Дата в прошлом 
                        headers['Cache-Control'] = ' no-cache, must-revalidate'; // HTTP/1.1 
                        headers['Pragma'] = ' no-cache'; // HTTP/1.1 
                        //headers['Last-Modified'] = ".gmdate("D, d M Y H:i:s")."GMT");

                        response.writeHead(200, "Ok", headers);
                        var data = {profile: result.rows[0]};
                        if("user" in request) data.user = request.user;
                        var output = mustache.render(user, data, {footer: footer});
                        response.write(output);
                        response.end();
                    });
                });
            }
    }
};

http.createServer(dispatcher).listen(7503, "localhost");
console.log('users.server running at http://localhost:7503');
