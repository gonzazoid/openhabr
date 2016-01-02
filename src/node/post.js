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
    request.post = {};
    request.post.id = req.path.trim().slice(1, -1);
    //console.log("id: ", id);
    pg.connect(config.common.postgres, function (err, pgClient, done) {
	if(err){
            console.log(err);
            response.end();
    	    return;
	}
        //TODO так мы светим и черновики. Где будем проверять - в запросе или же после получения данных из базы?
        //var sql = "SELECT * FROM articles WHERE id = $1 AND draft = false;";
        //var sql = "SELECT articles.*, M.hub_name, M.hub_title, M.hub_id FROM articles, (SELECT I.id, array_agg(J.title) as hub_title, array_agg(J.name) as hub_name, array_agg(J.id) as hub_id FROM (SELECT * FROM articles WHERE id = $1 AND draft = false) I, hubs J WHERE J.id = ANY(i.hubs) GROUP BY I.id) M WHERE M.id = articles.id;"
        var sql = "SELECT articles.*, M.hub_name, M.hub_title, M.hub_id, users.nickname, users.carma, users.rating as u_rating FROM articles, (SELECT I.id, array_agg(J.title) as hub_title, array_agg(J.name) as hub_name, array_agg(J.id) as hub_id FROM (SELECT * FROM articles WHERE id = $1 AND draft = false) I, hubs J WHERE J.id = ANY(i.hubs) GROUP BY I.id) M, users WHERE M.id = articles.id AND articles.author = users.id;"
        pgClient.query({
            text: sql
	   ,values: [request.post.id]
	}, function(err, result){
            //done();
	    if(err){
		console.log(err);
                response.end();
		return;
	    }
            if(result.rows.length != 1){
                //либо статья не найдена либо найдено больше одной статьи (что станно)
            }
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
                        //этот код никогда не должен сработать!
                        delete(item.hubs[i]);
                    }
                }
            });
            console.log(result.rows);
            var article = result.rows[0];
            //если есть комментарии - вытащим их (в дальнейшем надо перевести на queue, пока тянем последовательно
            //или отрисовку комментов сделать на клиенте? С точки зрения производительности - да, а вот с точки зрения индексации
            //лучше все таки комменты отдавать статикой
            //ok, сделаем и так и так
            sql = "SELECT * FROM comments WHERE article_id = $1;";
            pgClient.query({
                text: sql
	       ,values: [request.post.id]
	    }, function(err, result){
                done();
	        if(err){
                //TODO тут бы по хорошему вывести статью, просто без комментариев
		    console.log(err);
                    response.end();
		    return;
	        }
                console.log(result.rows);
                //ок, выстроим дерево
                //коммент - объект вида "{id: "", body: "", author: "", comments: []}
                //перенесем все корневые комменты в наш массив
                //создадим объект X где ключ - id коммента, значение - сам коммент
                //пройдемся исходному списку и по reply_to запушим комменты в comments владельца
                //делаем вывод корневых эелементов - имеем построенное дерево, но! пока еще не упорядоченное по stamp-ам
                //хотя есть мысль что если взять изначально отсортированный список (силами sql) - то и результат будет отсортирован
                var root = result.rows.filter((cv) => cv.reply_to == 0);
                console.log(root);
                //ok, перекидываем
                var by_id = {};
                for(i=0, l=result.rows.length; i<l; i++){
                    by_id[result.rows[i].id] = result.rows[i];
                }
                var headers = {};

                headers['Content-Type'] = 'text/html';
                headers['Expires'] = 'Mon, 26 Jul 1997 05:00:00 GMT'; //Дата в прошлом 
                headers['Cache-Control'] = ' no-cache, must-revalidate'; // HTTP/1.1 
                headers['Pragma'] = ' no-cache'; // HTTP/1.1 
                //headers['Last-Modified'] = ".gmdate("D, d M Y H:i:s")."GMT");

                response.writeHead(200, "Ok", headers);
                var output = mustache.render(pattern, {user: {name: "me"}, article: article});
                response.write(output);
                response.write(JSON.stringify(result.rows));
                response.write(JSON.stringify(by_id));
                response.end();
             });
	});
    });
};

http.createServer(worker).listen(7501, "localhost");
console.log('views.server running at http://localhost:7501');
