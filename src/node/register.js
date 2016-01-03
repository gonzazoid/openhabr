var http = require("http");
var qs = require('querystring');
var fs = require("fs");
var pg = require("pg");
var sha3 = require("js-sha3").sha3_512;
var mustache = require("mustache");

var config = require("./config");

var pattern = fs.readFileSync("./tpl/register.tpl", "utf-8");
var footer = fs.readFileSync("./tpl/footer.tpl", "utf-8");

var worker = function(request, response){
    
    //проверим action
    //если newuser - пришли данные на регистрацию
    console.log(request.url);
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
                var sql = "select adduser($1, $2, $3);"
                pgClient.query({
                    text: sql
	           ,values: [request.post.nickname, request.post.mailbox, sha3(request.post.sword)]
	        }, function(err, result){
                    done();
	            if(err){
		        console.log(err);
                        response.end();
		        return;
	            }
                    console.log(result);
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
                });
            });
            break;
        case "/":
            //если нет никаких action - просто выводим форму регистрации
            pg.connect(config.common.postgres, function (err, pgClient, done) {
	        if(err){
                    console.log(err);
                    response.end();
    	            return;
	        }

                var sql = ""
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
                    var output = mustache.render(pattern, {});
                    response.write(output);
	            //response.write(JSON.stringify(result.rows));
                    response.end();
	        });
            });
            break;
    }


};
var starter = function (request, response) {
    if (request.method == 'POST') {
        var body = '';

        request.on('data', function (data) {
            body += data;

            // Too much POST data, kill the connection!
            // 1e6 === 1 * Math.pow(10, 6) === 1 * 1000000 ~~~ 1MB
            if (body.length > 1e6)
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
