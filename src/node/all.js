"use strict";
//просто что бы видеть, какие модули используются
["http", "fs", "pg", "mustache", "./ext/bike", "./config"].forEach(cV => require(cV));

var pattern = fs.readFileSync("./tpl/all.tpl", "utf-8");
var footer = fs.readFileSync("./tpl/footer.tpl", "utf-8");

var dispatcher = function(request, response){

    var fw = require("./ext/bike");

         fw.prepare_headers({request, response})
   .then(fw.parse_cookies, fw.err)
   .then(fw.start_session, fw.err)
   .then(worker, fw.err)
   .then(fw.output, fw.err)
};

var worker = function(job){
    return new Promise(function(resolve, reject){
        //TODO перевести на pg-then
        var pg = require("pg");
        var config = require("./config");

        pg.connect(config.common.postgres, function (err, pgClient, done) {
	    if(err){
                console.log(err);
                reject();
    	        return;
	    }

            var sql = "SELECT V.*,  M.hub_title, M.hub_id, M.hub_name, users.nickname FROM (    SELECT I.id, I.stamp, array_agg(J.title) as hub_title, array_agg(J.id) as hub_id, array_agg(J.name) as hub_name     FROM (        SELECT * FROM articles WHERE draft = false ORDER BY stamp DESC LIMIT 10    ) I, hubs J     WHERE  J.id = ANY(I.hubs) GROUP BY I.id, I.stamp, I.hubs  ORDER BY I.stamp ASC) M, articles V, users WHERE M.id = V.id AND V.author = users.id ORDER BY stamp ASC;"
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
                "data" in job.response.habr || (job.response.habr.data = {});
                job.response.habr.data = {articles: result.rows};
                job.response.habr.pattern = pattern;
                job.response.habr.patterns = {footer};
                resolve(job);
	    });
        });
    });
};

http.createServer(dispatcher).listen(7500, "localhost");
console.log('views.server running at http://localhost:7500');
