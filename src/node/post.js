var http = require("http");
var fs = require("fs");
var pg = require("pg");
var url = require("url");
var mustache = require("mustache");

var config = require("./config");

var pattern = fs.readFileSync("./tpl/article.tpl", "utf-8");

var worker = function(request, response){
    //обработаем запрос, вытащим id запрашиваемой статьи
    var req = url.parse(request.url);
    console.log(req);
    if(!/^\/[0-9]+\/$/.test(req.path.trim())){
        //возвращаем 404
    }
    var id = req.path.trim().slice(1, -1);
    console.log("id: ", id);
    pg.connect(config.common.postgres, function (err, pgClient, done) {
	if(err){
            console.log(err);
            response.end();
    	    return;
	}
        //TODO так мы светим и черновики. Где будем проверять - в запросе или же после получения данных из базы?
        var sql = "SELECT * FROM articles WHERE id = $1;";
        pgClient.query({
            text: sql
	    values: [id]
	}, function(err, result){
            done();
	    if(err){
		console.log(err);
                response.end();
		return;
	    }
            if(result.rows.length != 1){
                //либо статья не найдена либо найдено больше одной статьи (что станно)
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
