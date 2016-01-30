"use strict";
//просто что бы видеть, какие модули используются
["http", "fs", "pg", "querystring", "url", "js-sha3", "mustache", "./bike", "./config"].forEach(cV => require(cV));

var app = require("express")();
//var http = require("http");
var fs = require("fs");
var fw = require("./bike");
var cookies = require("cookie-parser");

var patterns = {
    pattern: fs.readFileSync("./tpl/user.tpl", "utf-8")
   ,footer : fs.readFileSync("./tpl/footer.tpl", "utf-8")
   ,users  : fs.readFileSync("./tpl/users.tpl", "utf-8")
   ,user   : fs.readFileSync("./tpl/user.tpl", "utf-8")
   ,user_topics : fs.readFileSync("./tpl/user_topics.tpl", "utf-8")
};
app.use(fw.prepare_headers)
   .use(cookies())
   .use(fw.start_session)
   .get("/", function(req, res){

        var pg = require("pg");
        var config = require("./config");
        var fw = require("./bike");
        //если нет никаких данных - просто выводим список пользователей
        pg.connect(config.common.postgres, function (err, pgClient, done) {
	    if(err){
                console.log(err);
                fw.err(res);
    	        return;
	    }
            var sql = "SELECT * FROM users ORDER BY carma DESC LIMIT 20;";   
            pgClient.query({
                text: sql
	        // ,values: argv
	    }, function(err, result){
                done();
	        if(err){
		    console.log(err);
                    fw.err(res);
		    return;
	        }
 
                var mustache = require("mustache");
                var data = {};
                data.users = result.rows;
                "user" in req && (data.user = req.user);
	        res.status(200)
	           .send(mustache.render(patterns.users, data, patterns))
	           .end();
            });
        });
   })
   .get("^\/[a-zA-z0-9_\-]+\/$", function(req, res){
       var pg = require("pg");
       var config = require("./config");
       var fw = require("./bike");

       console.log(req.url);
       var result = req.url.split("/");
       console.log(res);
       var nickname = result[1];
       pg.connect(config.common.postgres, function (err, pgClient, done) {
           if(err){
               console.log(err);
               done();
               fw.err(res);
    	       return;
	   }
           var sql = "SELECT * FROM get_user_by_name($1);";   
           pgClient.query({
               text: sql
	      ,values: [nickname]
	   }, function(err, result){
               done();
	       if(err){
	           console.log(err);
                   fw.err(res);
		   return;
	       }   
               if(result.rows.length != 1){
                   //TODO что то пошло не так
               }
               //сольем медальки
               var medals = {};
               var i, l;
               for(i=0, l=result.rows[0].medals.length; i<l; i++){
                   medals[result.rows[0].medals[i]] = {title      : result.rows[0].medal_title[i]
                                                      ,description: result.rows[0].medal_description[i]};
               }
               for(i=0, l=result.rows[0].medals.length; i<l; i++){
                   result.rows[0].medals[i] =  medals[result.rows[0].medals[i]];
               }


               var mustache = require("mustache");
	       var data = {};
               data.profile = result.rows[0];
               "user" in req && (data.user = req.user);
	       res.status(200)
	          .send(mustache.render(patterns.user, data, patterns))
	          .end();
           });
       });
    })
    .get("^\/[a-zA-z0-9_\-]+\/topics\/$", function(req, res){
        var pg = require("pg");
        var config = require("./config");

        pg.connect(config.common.postgres, function (err, pgClient, done) {
            //{{{
            if(err){
                console.log(err);
                fw.err(res);
                return;
            }

            var result = req.url.split("/");
            console.log(res);
            var nickname = result[1];
            var sql = "SELECT * FROM get_user_by_name($1);";   
            pgClient.query({
		//{{{
                text: sql
	       ,values: [nickname]
	    }, function(err, result){
                //done();
	        if(err){
	            done();
	            console.log(err);
                    fw.err(res);
		    return;
	        }   
                if(result.rows.length != 1){
                    //TODO что то пошло не так
                }



                var sql = "SELECT V.*,  M.hub_title, M.hub_id, M.hub_name, users.nickname FROM (    SELECT I.id, I.stamp, array_agg(J.title) as hub_title, array_agg(J.id) as hub_id, array_agg(J.name) as hub_name     FROM (        SELECT * FROM articles WHERE draft = false AND author=$1 ORDER BY stamp DESC LIMIT 10    ) I, hubs J     WHERE  J.id = ANY(I.hubs) GROUP BY I.id, I.stamp, I.hubs  ORDER BY I.stamp DESC) M, articles V, users WHERE M.id = V.id AND V.author = users.id ORDER BY stamp DESC;"
                pgClient.query({
                    //{{{
                    text: sql
                    values: [result.rows[0].id]
                }, function(err, result){
                    done();
                    if(err){
	                console.log(err);
                        fw.err(res);
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
                    var mustache = require("mustache");
                    var data = {};
                    data.articles = result.rows;
                    "user" in req && (data.user = req.user);
                    res.status(200)
                       .send(mustache.render(patterns.user_topics, data, patterns))
                       .end();
                    //}}}
	        });
		    //}}}
            });
	    //}}}
        });
    })
.listen(7503, "localhost", undefined,() => console.log('users.server running at http://localhost:7503'));
