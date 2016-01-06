var http = require("http");
var qs = require('querystring');
var fs = require("fs");
var pg = require("pg");
var sha3 = require("js-sha3").sha3_512;
var mustache = require("mustache");

var config = require("./config");

var pattern = fs.readFileSync("./tpl/user.tpl", "utf-8");
var footer = fs.readFileSync("./tpl/footer.tpl", "utf-8");
var users = fs.readFileSync("./tpl/users.tpl", "utf-8");
var user = fs.readFileSync("./tpl/user.tpl", "utf-8");

var worker = function(request, response){
    
    //проверим action
    //если newuser - пришли данные на регистрацию
    console.log(request.post);
    switch(request.url){
        case "/":
            //если нет никаких данных - просто выводим список пользователей
            pg.connect(config.common.postgres, function (err, pgClient, done) {
	        if(err){
                    console.log(err);
                    response.end();
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
                        response.end();
		        return;
	            }
           
                    var headers = {};

                    headers['Content-Type'] = 'text/html';
                    headers['Expires'] = 'Mon, 26 Jul 1997 05:00:00 GMT'; //Дата в прошлом 
                    headers['Cache-Control'] = ' no-cache, must-revalidate'; // HTTP/1.1 
                    headers['Pragma'] = ' no-cache'; // HTTP/1.1 
                    //headers['Last-Modified'] = ".gmdate("D, d M Y H:i:s")."GMT");

                    response.writeHead(200, "Ok", headers);
                    var data = {users: result.rows};
                    if("user" in request) data.user = request.user;
                    var output = mustache.render(users, data, {footer: footer});
                    response.write(output);
                    //response.write(JSON.stringify(result.rows));
                    response.end();
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
                        if("medals" in result.rows[0]){
                            var medals = {};
                            for(i=0, l=result.rows[0].medals.length; i<l; i++){
                                medals[result.rows[0].medals[i]] = {title:       result.rows[0].medal_title[i]
                                                                   ,description: result.rows[0].medal_description[i]};
                            }
                            for(i=0, l=result.rows[0].medals.length; i<l; i++){
                                result.rows[0].medals[i] =  medals[result.rows[0].medals[i]];
                            }
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
var parseCookies = function (request) {//TODO audit&refactoring&error handling
    //console.log(this.headers);
    var cookies = {};

    if (request.headers.cookie !== undefined) {
        var rc = request.headers.cookie.split(';');

        for (var cookie in rc) {
            var parts = rc[cookie].split('=');
            //TODO проверка на разбивку (должно быть точно два элемента)
            if (parts.length !== 2) {
                //this.forbidden();
                console.log("wrong cookies");
            }else{
                cookies[parts[0].trim()] = parts[1].trim();
            }
        }
    }
    //console.log(this.cookies);
    return cookies;
};
var start_session = function(request, response){
    request.cookies = parseCookies(request); 
    if("id" in request.cookies){
        //тянем сессию
        pg.connect(config.common.postgres, function (err, pgClient, done) {
	    if(err){
                console.log(err);
                response.end();
    	        return;
	    }
            var sql = "SELECT * FROM users WHERE sid = $1;"
            pgClient.query({
                text: sql
	       ,values: [request.cookies.id]
	    }, function(err, result){
                done();
	        if(err){
		    console.log(err);
                    response.end();
		    return;
	        } 
                if(result.rows.length == 1){
                    request.user = result.rows[0];
                }
                worker(request, response);
            });
        });
    }else{
        worker(request, response);
    }
};
var starter = function (request, response) {
    if (request.method == 'POST') {
        var body = '';

        request.on('data', function (data) {
            body += data;

            if (body.length > 4096)
                request.connection.destroy();
        });

        request.on('end', function () {
            request.post = qs.parse(body);
            start_session(request, response);
        });
    }else{
        request.post = {};
        start_session(request, response);
    }
};

http.createServer(starter).listen(7503, "localhost");
console.log('users.server running at http://localhost:7503');
