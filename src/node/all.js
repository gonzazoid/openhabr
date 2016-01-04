var http = require("http");
var fs = require("fs");
var pg = require("pg");
var mustache = require("mustache");

var config = require("./config");

var pattern = fs.readFileSync("./tpl/all.tpl", "utf-8");
var footer = fs.readFileSync("./tpl/footer.tpl", "utf-8");

var worker = function(request, response){
    pg.connect(config.common.postgres, function (err, pgClient, done) {
	if(err){
            console.log(err);
            response.end();
    	    return;
	}
        //TODO нам бы тут еще тэги с чисел на строки поменять
        //var sql = "SELECT I.*, array_agg(J.title) FROM (SELECT * FROM articles WHERE draft = false ORDER BY stamp DESC LIMIT 10) I LEFT JOIN tags J ON J.id = ANY(i.tags) GROUP BY I.id, ORDER BY I.stamp ASC;";
        //var sql = "SELECT V.*,  M.tags_title, M.tags_id FROM (SELECT I.id, I.stamp, array_agg(J.title) as tags_title, array_agg(J.id) as tags_id FROM (SELECT * FROM articles WHERE draft = false ORDER BY stamp DESC LIMIT 10) I, tags J WHERE  J.id = ANY(I.tags) GROUP BY I.id, I.stamp, I.tags  ORDER BY I.stamp ASC) M, articles V WHERE M.id = V.id ORDER BY stamp ASC;"
        //подтянем данные авторов
        //var sql = "SELECT V.*,  M.hub_title, M.hub_id, M.hub_name FROM (SELECT I.id, I.stamp, array_agg(J.title) as hub_title, array_agg(J.id) as hub_id, array_agg(J.name) as hub_name FROM (SELECT * FROM articles WHERE draft = false ORDER BY stamp DESC LIMIT 10) I, hubs J WHERE  J.id = ANY(I.hubs) GROUP BY I.id, I.stamp, I.hubs  ORDER BY I.stamp ASC) M, articles V WHERE M.id = V.id ORDER BY stamp ASC;"
        var sql = "SELECT V.*,  M.hub_title, M.hub_id, M.hub_name, users.nickname FROM (    SELECT I.id, I.stamp, array_agg(J.title) as hub_title, array_agg(J.id) as hub_id, array_agg(J.name) as hub_name     FROM (        SELECT * FROM articles WHERE draft = false ORDER BY stamp DESC LIMIT 10    ) I, hubs J     WHERE  J.id = ANY(I.hubs) GROUP BY I.id, I.stamp, I.hubs  ORDER BY I.stamp ASC) M, articles V, users WHERE M.id = V.id AND V.author = users.id ORDER BY stamp ASC;"
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

            //сольем вместе hub_title, id и name
            result.rows.forEach(function(item, key, holder){
                var hubs = [];
                var i, l;
                if(!item.hubs.length) return;
                for(i=0, l=item.hub_id.length; i<l; i++){
                    hubs[item.hub_id[i]] = {id: item.hub_id[i], name: item.hub_name[i], title: item.hub_title[i]};
                }
                for(i=0, l=item.hubs.length; i<l; i++){
                    if(item.hubs[i] in hubs){
                        item.hubs[i] = hubs[item.hubs[i]];
                    }else{
                        delete(item.hubs[i]);
                    }
                }
            });
            var headers = {};

            headers['Content-Type'] = 'text/html';
            headers['Expires'] = 'Mon, 26 Jul 1997 05:00:00 GMT'; //Дата в прошлом 
            headers['Cache-Control'] = ' no-cache, must-revalidate'; // HTTP/1.1 
            headers['Pragma'] = ' no-cache'; // HTTP/1.1 
            //headers['Last-Modified'] = ".gmdate("D, d M Y H:i:s")."GMT");

            response.writeHead(200, "Ok", headers);
            var data = {articles: result.rows};
            if("user" in request) data.user = request.user;
            var output = mustache.render(pattern, data, {footer: footer});
            response.write(output);
	    //response.write(JSON.stringify(result.rows));
            response.end();
	});
    });
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

http.createServer(start_session).listen(7500, "localhost");
console.log('views.server running at http://localhost:7500');
