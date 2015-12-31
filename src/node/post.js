var http = require("http");
var fs = require("fs");
var pg = require("pg");
var mustache = require("mustache");

var config = require("./config");

var pattern = fs.readFileSync("./tpl/article.tpl", "utf-8");

var worker = function(request, response){
    pg.connect(config.common.postgres, function (err, pgClient, done) {
	if(err){
            console.log(err);
            response.end();
    	    return;
	}
        var sql = "SELECT * FROM articles WHERE id = 2;";
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
            var output = mustache.render(pattern, {user: {name: "me"}, article: result.rows[0]});
            response.write(output);
            response.end();
	});
    });
};

http.createServer(worker).listen(7501, "localhost");
console.log('views.server running at http://localhost:7501');
