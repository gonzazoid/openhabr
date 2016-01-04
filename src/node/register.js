var http = require("http");
var qs = require('querystring');
var fs = require("fs");
var pg = require("pg");
var sha3 = require("js-sha3").sha3_512;
var mustache = require("mustache");

var config = require("./config");

var pattern = fs.readFileSync("./tpl/register.tpl", "utf-8");
var footer = fs.readFileSync("./tpl/footer.tpl", "utf-8");
var congratulations = fs.readFileSync("./tpl/congratulations.tpl", "utf-8");

var rndHex = function (len) {
    var id = '';
    var map = '0123456789abcdef';

    for (var $i = 0; $i < len; $i++) {
        id += map.charAt(Math.floor(Math.random() * 16));
    }

    return id;
};

var worker = function(request, response){
    
    //проверим action
    //если newuser - пришли данные на регистрацию
    console.log(request.post);
    switch(request.url){
        case "/newuser":
            //регистрируем новичка
            console.log(request.post);
            pg.connect(config.common.postgres, function (err, pgClient, done) {
	        if(err){
                    console.log(err);
                    response.end();
    	            return;
	        }
                var sql = "select * from adduser($1, $2, $3, $4);"
                var sid = rndHex(128);
                pgClient.query({
                    text: sql
	           ,values: [request.post.nickname, request.post.mailbox, sha3(request.post.sword), sid]
	        }, function(err, result){
                    done();
	            if(err){
		        console.log(err);
                        response.end();
		        return;
	            }
                    console.log(result);
                    // если все хорошо - выставляем куки и поздравляем с регистрацией
                    if(result.rows[0].adduser){
                        var headers = {};
                        //куки авторизации
                        headers["Set-Cookie"] = 'id=' + sid + '; path=/; HttpOnly;';
                        headers['Content-Type'] = 'text/html';
                        headers['Expires'] = 'Mon, 26 Jul 1997 05:00:00 GMT'; //Дата в прошлом 
                        headers['Cache-Control'] = ' no-cache, must-revalidate'; // HTTP/1.1 
                        headers['Pragma'] = ' no-cache'; // HTTP/1.1 
                        //headers['Last-Modified'] = ".gmdate("D, d M Y H:i:s")."GMT");

                        response.writeHead(200, "Ok", headers);
                        var output = mustache.render(congratulations, {user: {nickname: request.post.nickname}}, {footer: footer});
                        response.write(output);
	                //response.write(JSON.stringify(result.rows));
                        response.end();  
                    }else{//что то пошло не так - просим повторить заново (логин либо почта уже есть в системе)
                    var headers = {};

                    headers['Content-Type'] = 'text/html';
                    headers['Expires'] = 'Mon, 26 Jul 1997 05:00:00 GMT'; //Дата в прошлом 
                    headers['Cache-Control'] = ' no-cache, must-revalidate'; // HTTP/1.1 
                    headers['Pragma'] = ' no-cache'; // HTTP/1.1 
                    //headers['Last-Modified'] = ".gmdate("D, d M Y H:i:s")."GMT");

                    response.writeHead(200, "Ok", headers);
                    var output = mustache.render(pattern, {});
                    response.write(output);
	            //response.write(JSON.stringify(result.rows));
                    response.end();
                    }
                });
            });
            break;
        case "/":
            //если нет никаких action - просто выводим форму регистрации
            
            var headers = {};

            headers['Content-Type'] = 'text/html';
            headers['Expires'] = 'Mon, 26 Jul 1997 05:00:00 GMT'; //Дата в прошлом 
            headers['Cache-Control'] = ' no-cache, must-revalidate'; // HTTP/1.1 
            headers['Pragma'] = ' no-cache'; // HTTP/1.1 
            //headers['Last-Modified'] = ".gmdate("D, d M Y H:i:s")."GMT");

            response.writeHead(200, "Ok", headers);
            var output = mustache.render(pattern, {});
            response.write(output);
            //response.write(JSON.stringify(result.rows));
            response.end();
            break;
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
            worker(request, response);
        });
    }else{
        request.post = {};
        worker(request, response);
    }
};

http.createServer(starter).listen(7502, "localhost");
console.log('views.server running at http://localhost:7502');
