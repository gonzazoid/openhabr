var http = require("http");
//= inc/http.request.ext.js
//= inc/http.response.ext.js

var pg = require("pg");
var db = require("./ext/sqrator");

var config = require("./config");

var validator = require('validator');
var worker = require('./ext/http.worker');
var session = require('./ext/session');

var proto = http.IncomingMessage.prototype;

//{{{ urlslistslist secured
proto.rtable['/urlslists_list'] = function(request, response){
    var worker = function(request, response){
        db.reply(pg, config, response, "v3_get_urlslists_list", [request.user.id]);
    };
    session.start(request, response, worker);
};
//}}}
//{{{ urlslistsurlslist secured
proto.rtable['/urlslistsurlslist'] = function(request, response){
    var worker = function(request, response){
	var rules = {
            "urlslist-id": {"flags": "required", "type": "integer"}
	   //,"site":    {"flags": "notRequired", "type": "string"}
        };
        try {
            request.post = validator(request.post, rules);
        } catch (err) {
            console.log("urlslisturls bad request:\nuser:\n",
                        request.user,
                        "\npost:\n", request.post,
                        "\nsql error\n", err);
            response.reply({"status": 400, "msg": "bad request"});
	    return;
        }
        db.reply(pg, config, response, "v3_get_urlslist_urls", [request.user.id, request.post["urlslist-id"]]);
    };
    session.start(request, response, worker);
};
//}}}

//{{{ v3 siteslist secured logged
proto.rtable['/siteslist'] = function(request, response){
    var worker = function(request, response){
	db.reply(pg, config, response, "v3_get_sites_list", [request.user.id]);
    };
    session.start(request, response, worker);
};
//}}}
//{{{ v3 urlslist secured logged
proto.rtable['/urlslist'] = function(request, response){
    var worker = function(request, response){
	var rules = {
            "context"   : {"flags": "required", "type": "integer"}
	   ,"context-id": {"flags": "required", "type": "integer"}
        };
        try {
            request.post = validator(request.post, rules);
        } catch (err) {
	        console.log("urlslist bad request:\nuser:\n", request.user, "\npost:\n", request.post, "\nsql error\n", err);
            response.reply({"status": 400, "msg": "bad request"});
	    return;
        }
	//TODO отработать промах по индексу
	var sql = ["v3_get_site_urls", "v3_get_urlslist_urls"][parseInt(request.post["context"]) - 1];
	db.reply(pg, config, response, sql, [request.user.id, request.post["context-id"]]);
    };
    session.start(request, response, worker);
};
//}}}
//{{{ v3 indexresults secured logged
proto.rtable['/indexresults'] = function(request, response){
    var worker = function(request, response){
	var rules = {
            "site-id": {"flags": "required", "type": "integer"}
        };
        try {
            request.post = validator(request.post, rules);
        } catch (err) {
	        console.log("indexresults bad request:\nuser:\n", request.user, "\npost:\n", request.post, "\nsql error\n", err);
            response.reply({"status": 400, "msg": "bad request"});
	    return;
        }
	console.log("indexresults called");
	//response.reply({"id": 1, "httpstatus": "200"});
	db.reply(pg, config, response, "v3_get_last_index_results", [request.user.id, request.post["site-id"]]);
    };
    session.start(request, response, worker);
};
//}}}
//{{{ v3 checkindexresults secured logged
//TODO тут предстоит переделка по типу поисковика
proto.rtable['/checkindexresults'] = function(request, response){
    var worker = function(request, response){
	//response.reply("ok");
	//return;
	var rules = {
            "site-id": {"flags": "required", "type": "integer"}
	   ,"se"     : {"flags": "required", "whiteList": "yandex"}
        };
        try {
            request.post = validator(request.post, rules);
        } catch (err) {
	        console.log("indexresults bad request:\nuser:\n", request.user, "\npost:\n", request.post, "\nsql error\n", err);
            response.reply({"status": 400, "msg": "bad request"});
	    return;
        }
	console.log("indexresults called");
	//response.reply({"id": 1, "httpstatus": "200"});
	db.reply(pg, config, response, "v3_get_last_check_index_results", [request.user.id, request.post["site-id"], request.post["se"]]);
    };
    session.start(request, response, worker);
};
//}}}

//{{{ siteinfo secured TODO - он вообще используется? похоже атавизм
proto.rtable['/siteinfo'] = function(request, response){
    var worker = function(request, response){
	var rules = {
            "site-id": {"flags": "required", "type": "integer"}
	   //,"site":    {"flags": "required", "type": "string"}
        };
        try {
            request.post = validator(request.post, rules);
        } catch (err) {
	    //TODO вменяемое логирование
	    console.log(err);
            response.reply({"status": 400, "msg": "bad request"});
	    return;
        }
        response.setHeaders();
        pg.connect(config.common.postgres, function (err, pgClient, done) {
            //ок, функция работает
            //console.log("start sql query executing");
	    //console.log(request.post);
	    //response.reply(true);
	    //return;
            //ok, возвращаем статус robots, наличие sitemap, их ссылки и статус их обработки
            var sql = "select * from sites where id = $2 and owner = $1;";
	    console.log(request.post);
            pgClient.query({
                    text: sql,
                    values: [request.user.id, request.post["site-id"]]
                }, function (err, result) {
		    //done();
                    if (err) {
                        response.reply(false);
                        return;
                    }else{
			//по полученным данным вытаскиваем robots.txt и sitemaps
			if(result.rows.length !== 1){
                            //нет такого сайта
		            response.reply(false);
			    return;
			}else{
			    //TODO в дальнейшем и dns ответ
			    //не привязываемся к id сайта(в robots) поскольку за сайтом могут смотреть несколько участников
			    //и соотв. у сайта может быть несколько id
			    var sql = 'select * from v3_getrobots($1);';
                            pgClient.query({
                                text: sql,
                                values: [result.rows[0].proto + result.rows[0].domain + ":" + result.rows[0].port]
			    },  function (err, result) {
		                done();
                                if (err) {
                                    response.reply(false);
                                    return;
                                }
                                if(result.rows.length !== 1){
                                    //либо robots не прописан (ни разу не запрашивался, что странно, так сайт то в базе есть [возможно только закачивается]
                                    response.reply(false);
                                    return;
                                    //либо какая то ошибка
			        }
			        response.reply({
				    "site": request.post["site-id"],
				    "robots": {"status": result.rows[0].status,
			                       "lastupdated": result.rows[0].last_updated, 
			  	               "sitemaps": result.rows[0].sitemaps
				              }
				});
			        return;
			    });
                        }
                    }
                });
        });
    };
    session.start(request, response, worker);
};
//}}}
//{{{ getrobots secured
proto.rtable['/getrobots'] = function(request, response){
    var worker = function(request, response){
	var rules = {
            "site-id": {"flags": "required", "type": "integer"}
        };
        try {
            request.post = validator(request.post, rules);
        } catch (err) {
	    //TODO вменяемое логирование
	    console.log(err);
            response.reply({"status": 400, "msg": "bad request"});
	    return;
        }
        response.setHeaders();
        pg.connect(config.common.postgres, function (err, pgClient, done) {
            //ок, функция работает
            //console.log("start sql query executing");
	    //console.log(request.post);
	    //response.reply(true);
	    //return;
            //ok, возвращаем статус robots, наличие sitemap, их ссылки и статус их обработки
            var sql = 'select * from sites, "robots.txt" as robots where sites.id = $2 and sites.owner = $1 and robots.site = concat(sites.proto, sites.domain, \':\', sites.port);';
	    console.log(request.post);
            pgClient.query({
                    text: sql,
                    values: [request.user.id, request.post["site-id"]]
                }, function (err, result) {
		    done();
                    if (err) {
                        response.reply(false);
                        return;
                    }else{
			//по полученным данным вытаскиваем robots.txt и sitemaps
			if(result.rows.length !== 1){
                            //нет такого сайта
		            response.reply(false);
			    return;
			}else{
                            response.reply({
                                "site": request.post["site-id"],
                                "robots": result.rows[0]
                            });
                            return;
                        }
                    }
                });
        });
    };
    session.start(request, response, worker);
};
//}}}
//{{{ getdns secured
proto.rtable['/getdns'] = function(request, response){
    var worker = function(request, response){
	var rules = {
            "site-id": {"flags": "required", "type": "integer"}
        };
        try {
            request.post = validator(request.post, rules);
        } catch (err) {
	    //TODO вменяемое логирование
	    console.log(err);
            response.reply({"status": 400, "msg": "bad request"});
	    return;
        }
        response.setHeaders();
        pg.connect(config.common.postgres, function (err, pgClient, done) {
            //ok, возвращаем статус robots, наличие sitemap, их ссылки и статус их обработки
            var sql = 'select * from sites, dns  where sites.id = $2 and sites.owner = $1 and dns.domain = sites.domain;';
	    console.log(request.post);
            pgClient.query({
                    text: sql,
                    values: [request.user.id, request.post["site-id"]]
                }, function (err, result) {
		    done();
                    if (err) {
                        response.reply(false);
                        return;
                    }else{
			//по полученным данным вытаскиваем robots.txt и sitemaps
			if(result.rows.length !== 1){
                            //нет такого сайта
		            response.reply(false);
			    return;
			}else{
			    delete result.rows[0].records.err;
                            response.reply({
                                "site": request.post["site-id"],
                                "dns": result.rows[0]
                            });
                            return;
                        }
                    }
                });
        });
    };
    session.start(request, response, worker);
};
//}}}
//{{{ v3 taskstatus secured logged
proto.rtable['/taskstatus'] = function(request, response){
    var worker = function(request, response){
	var rules = {
            "task-id": {"flags": "required", "type": "integer"}
        };
        try {
            request.post = validator(request.post, rules);
        } catch (err) {
	    console.log("taskstatus bad request:\nuser:\n", request.user, "\npost:\n", request.post, "\nsql error\n", err);
            response.reply({"status": 400, "msg": "bad request"});
	    return;
        }
	db.reply(pg, config, response, "v3_get_task_status", [request.user.id, request.post["task-id"]]);
    };
    session.start(request, response, worker);
};
//}}}
//{{{ checkIndexationstatus secured
proto.rtable['/checkindexationstatus'] = function(request, response){
    var worker = function(request, response){
	var rules = {
            "site-id": {"flags": "required", "type": "integer"}
        };
        try {
            request.post = validator(request.post, rules);
        } catch (err) {
	    //TODO вменяемое логирование
	    console.log(err);
            response.reply({"status": 400, "msg": "bad request"});
	    return;
        }
        response.setHeaders();
        pg.connect(config.common.postgres, function (err, pgClient, done) {
	    console.log(request.post);
            pgClient.query({
                    text: "select * from getcheck_yandex_indexationstatus($1, $2);",
                    values: [request.user.id, request.post["site-id"]]
                }, function (err, result) {
		    done();
                    if (err) {
                        response.reply(false);
                        return;
                    }else{
			    //TODO result.rows.length
			response.reply(result.rows);
			return;
		    }
		});
	});
    };
    session.start(request, response, worker);
};
//}}}
//{{{ v3 taskslist secured logged
proto.rtable['/taskslist'] = function(request, response){
    var worker = function(request, response){
	var rules = {
            "context"    : {"flags": "required", "type": "integer"} //TODO whitelist
           ,"context-id" : {"flags": "required", "type": "integer"}
        };
        try {
            request.post = validator(request.post, rules);
        } catch (err) {
	    console.log("taskslist bad request:\nuser:\n", request.user, "\npost:\n", request.post, "\nerror\n", err);
            response.reply({"status": 400, "msg": "bad request"});
	    return;
        }
	
	db.reply(pg, config, response, "v3_get_tasks_list", [request.user.id, request.post.context, request.post["context-id"]]);
    };
    session.start(request, response, worker);
};
//}}}

http.createServer(worker.onRequest).listen(config.views.port, config.views.host);
console.log('views.server running at http://localhost:' + config.views.port);
