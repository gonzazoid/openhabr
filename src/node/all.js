var http = require("http");
var fs = require("fs");
var pg = require("pg");
var mustache = require("mustache");

var config = require("./config");

var pattern = fs.readFileSync("./tpl/all.tpl", "utf-8");

var worker = function(request, response){
    pg.connect(config.common.postgres, function (err, pgClient, done) {
	if(err){
            console.log(err);
            response.end();
    	    return;
	}
        //TODO нам бы тут еще тэги с чисел на строки поменять
        //var sql = "SELECT I.*, array_agg(J.title) FROM (SELECT * FROM articles WHERE draft = false ORDER BY stamp DESC LIMIT 10) I LEFT JOIN tags J ON J.id = ANY(i.tags) GROUP BY I.id, ORDER BY I.stamp ASC;";
        var sql = "SELECT V.*,  M.tags_title, M.tags_id FROM (
SELECT I.id, I.stamp, array_agg(J.title) as tags_title, array_agg(J.id) as tags_id
FROM (
    SELECT * FROM articles WHERE draft = false ORDER BY stamp DESC LIMIT 10
) I, tags J
--можно в каждой строке выбирать тег и его id а потом агрегировать обоих
WHERE  J.id = ANY(I.tags) GROUP BY I.id, I.stamp, I.tags  ORDER BY I.stamp ASC) M, articles V
WHERE M.id = V.id ORDER BY stamp ASC;"
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
            var output = mustache.render(pattern, {user: {name: "me"}, articles: result.rows});
            response.write(output);
	    response.write(JSON.stringify(result.rows));
            response.end();
	});
    });
};

http.createServer(worker).listen(7500, "localhost");
console.log('views.server running at http://localhost:7500');
