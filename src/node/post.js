"use strict";
//просто что бы видеть, какие модули используются
["http", "fs", "pg", "url", "mustache", "./bike", "./config"].forEach(cV => require(cV));

var fs = require("fs");
//var http = require("http");
var app = require("express")();
var fw = require("./bike");
var cookies = require("cookie-parser");

var patterns = {
    article:  fs.readFileSync("./tpl/article.tpl", "utf-8")
   ,comments: fs.readFileSync("./tpl/comments.tpl", "utf-8")
   ,footer:   fs.readFileSync("./tpl/footer.tpl", "utf-8")
};

app.use(fw.prepare_headers)
   .use(cookies())
   .use(fw.start_session)
   .get("/[0-9]+\/", function(req, res){

        var url = require("url");
        var pg = require("pg");
        var config = require("./config");
        var fw = require("./bike");

        //обработаем запрос, вытащим id запрашиваемой статьи
        var query = url.parse(req.url);
        console.log(req);
        //TODO вывести в модуль роутинга, и почему post а не get? 
        req.get = {};
        req.get.id = query.path.trim().slice(1, -1);
        //console.log("id: ", id);
        pg.connect(config.common.postgres, function (err, pgClient, done) {
        //{{{ error handling
	    if(err){
                done();
                console.log(err);
                fw.err(res);
    	        return;
	    }
        //}}} 
            var sql = "SELECT articles.*, M.hub_name, M.hub_title, M.hub_id, users.nickname, users.fullname, users.status as u_status, users.carma, users.rating as u_rating FROM articles, (SELECT I.id, array_agg(J.title) as hub_title, array_agg(J.name) as hub_name, array_agg(J.id) as hub_id FROM (SELECT * FROM articles WHERE id = $1 AND draft = false) I, hubs J WHERE J.id = ANY(i.hubs) GROUP BY I.id) M, users WHERE M.id = articles.id AND articles.author = users.id;"
            pgClient.query({
                text: sql
	       ,values: [req.get.id]
	    }, function(err, result){
		    //{{{
                //done();
	        if(err){
                    done();
		    console.log(err);
                    fw.err(res);
		    return;
	        }
                if(result.rows.length != 1){
                    //либо статья не найдена либо найдено больше одной статьи (что станно)
                }
                result.rows.forEach(function(item, key, holder){
		//{{{
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
		//}}}
                });
                //console.log(result.rows);
                var article = result.rows[0];
                //если есть комментарии - вытащим их (в дальнейшем надо перевести на queue, пока тянем последовательно
                //или отрисовку комментов сделать на клиенте? С точки зрения производительности - да, а вот с точки зрения индексации
                //лучше все таки комменты отдавать статикой
                //ok, сделаем и так и так
                sql = "SELECT comments.*, users.nickname FROM comments, users WHERE article_id = $1 AND comments.author = users.id ORDER BY stamp ASC;";
                pgClient.query({
                    text: sql
	           ,values: [req.get.id]
	        }, function(err, result){
		//{{{
                    done();
	            if(err){
                        //TODO тут бы по хорошему вывести статью, просто без комментариев
		        console.log(err);
                        fw.err(res);
		        return;
	            }
                    //console.log(result.rows);
                    //ок, выстроим дерево
                    //коммент - объект вида "{id: "", body: "", author: "", comments: []}
                    //перенесем все корневые комменты в наш массив
                    //создадим объект X где ключ - id коммента, значение - сам коммент
                    //пройдемся исходному списку и по reply_to запушим комменты в comments владельца
                    //делаем вывод корневых эелементов - имеем построенное дерево, но! пока еще не упорядоченное по stamp-ам
                    //хотя есть мысль что если взять изначально отсортированный список (силами sql) - то и результат будет отсортирован
                    //var root = result.rows.filter((cv) => cv.reply_to == 0);
                    //console.log(root);
                    //ok, перекидываем
                    var i, l;
                    var by_id = {"0": {"comments": []}};
                    for(i=0, l=result.rows.length; i<l; i++){
                        result.rows[i].comments = [];
                        by_id[result.rows[i].id] = result.rows[i];
                    }
                    //ok, догружаем
		    //console.log("comments:", by_id);
                    for(i=0, l=result.rows.length; i<l; i++){
			if(result.rows[i].reply_to in by_id){
                            by_id[result.rows[i].reply_to].comments.push(result.rows[i]);
			}else{
                            //TODO это не нормально, коммент с каким то кривым предком
			}
                    }
                    //ok, в by_id["0"] имеем все дерево комментов
                    //пробуем рекурсивный шаблон вывода
                    article.comments = by_id["0"].comments;

                    var mustache = require("mustache");
                    var data = {};
                    data.article = article;
                    "user" in req && (data.user = req.user);
	            res.status(200)
	               .send(mustache.render(patterns.article, data, patterns))
	               .end();
		       //}}}
                });
		//}}}
	    });
        });
    })

.listen(7501, "localhost", undefined,() => console.log('post.server running at http://localhost:7501'));
console.log('views.server running at http://localhost:7501');
