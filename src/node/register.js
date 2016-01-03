var http = require("http");
var fs = require("fs");
var pg = require("pg");
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
            console.log

    }



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
};
var starter = function(request, response){
    var jsonString = '';
    request.on('data', function (data) {//TODO контролировать размер поста
        jsonString += data;
    });
    request.on('end', function () {
        console.log(jsonString);
        try {//TEST me!!!
            request.post = jsonString.length ? JSON.parse(jsonString) : {};
        } catch (error) {
            //console.log(jsonString);
            response.statusCode = 403;
            response.statusMessage = 'Forbidden';
            response.end();
            return;
        }
        handler(request, response);
    });
};
http.createServer(starter).listen(7502, "localhost");
console.log('views.server running at http://localhost:7502');
