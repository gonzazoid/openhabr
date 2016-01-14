"use strict";
//просто что бы видеть, какие модули используются
["express", "http", "fs", "pg", "mustache", "./bike", "./config"].forEach(cV => require(cV));

var fs = require("fs");
//var http = require("http");
var app = require("express")();
var fw = require("./bike");
var cookies = require("cookie-parser");

var patterns = {
    all: fs.readFileSync("./tpl/all.tpl", "utf-8")
   ,footer: fs.readFileSync("./tpl/footer.tpl", "utf-8")
};

app.use(fw.prepare_headers)
   .use(cookies());
   .use(fw.start_session)
   .get("/", function(req, res){
    console.log("worker", job);
    //TODO перевести на pg-then
    var pg = require("pg");
    var config = require("./config");

    pg.connect(config.common.postgres, function (err, pgClient, done) {
        if(err){
            console.log(err);
            reject();
            return;
        }

        var sql = "SELECT V.*,  M.hub_title, M.hub_id, M.hub_name, users.nickname FROM (    SELECT I.id, I.stamp, array_agg(J.title) as hub_title, array_agg(J.id) as hub_id, array_agg(J.name) as hub_name     FROM (        SELECT * FROM articles WHERE draft = false ORDER BY stamp DESC LIMIT 10    ) I, hubs J     WHERE  J.id = ANY(I.hubs) GROUP BY I.id, I.stamp, I.hubs  ORDER BY I.stamp DESC) M, articles V, users WHERE M.id = V.id AND V.author = users.id ORDER BY stamp DESC;"
        pgClient.query({
            text: sql
            // ,values: argv
        }, function(err, result){
            done();
            if(err){
	        console.log(err);
                reject();
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
	       .send(mustache.render(patterns.all, data, patterns))
	       .end();
	});
    });
})

.listen(7500, "localhost", undefined,() => console.log('views.server running at http://localhost:7500'));
