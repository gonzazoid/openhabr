var http = require("http");
var qs = require('querystring');
var fs = require("fs");
var pg = require("pg");
var sha3 = require("js-sha3").sha3_512;
var mustache = require("mustache");

var config = require("./config");

var auth = fs.readFileSync("./tpl/auth.tpl", "utf-8");
var footer = fs.readFileSync("./tpl/footer.tpl", "utf-8");

var worker = function(request, response){
    
    //проверим action
    //если newuser - пришли данные на регистрацию
    console.log(request.post);
    switch(request.url){
        case "/":
            //если нет никаких данных - просто выводим форму авторизации
            var headers = {};

            headers['Content-Type'] = 'text/html';
            headers['Expires'] = 'Mon, 26 Jul 1997 05:00:00 GMT'; //Дата в прошлом 
            headers['Cache-Control'] = ' no-cache, must-revalidate'; // HTTP/1.1 
            headers['Pragma'] = ' no-cache'; // HTTP/1.1 
            //headers['Last-Modified'] = ".gmdate("D, d M Y H:i:s")."GMT");

            response.writeHead(200, "Ok", headers);
            //TODO  тут вообще то если пользователь уже авторизован - надо бы ему сообщать об этом
            var data = {users: result.rows};
            if("user" in request) data.user = request.user;
            var output = mustache.render(auth, data, {footer: footer});
            response.write(output);
            //response.write(JSON.stringify(result.rows));
            response.end();
            break;
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
    }
    worker(request, response);
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

http.createServer(starter).listen(7504, "localhost");
console.log('auth.server running at http://localhost:7504');
