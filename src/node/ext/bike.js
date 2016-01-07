"use strict";
module.exports = {
    prepare_headers: function(job){
        //console.log(job);
        return new Promise(function(resolve, reject){
            "habr" in job.response || (job.response.habr = {});
            job.response.habr.headers = {};

            job.response.habr.headers['Content-Type'] = 'text/html';
            job.response.habr.headers['Expires'] = 'Mon, 26 Jul 1997 05:00:00 GMT'; //Дата в прошлом 
            job.response.habr.headers['Cache-Control'] = ' no-cache, must-revalidate'; // HTTP/1.1 
            job.response.habr.headers['Pragma'] = ' no-cache';

            resolve(job);
        });
    }
   ,parse_cookies: function(job){
        //console.log(job);
        return new Promise(function(resolve, reject){
            job.request.cookies = {};
            "cookie" in job.request.headers &&
            
                job.request.headers.cookie.split(';')
                                          .map(cV => cV.split('='))
                                          .map(cV => cV.length == 2 ? cV : null)
                                          .forEach(cV => cV && (job.request.cookies[cV[0].trim()] = cV[1].trim()));
            resolve(job);
        });
    }
    ,start_session: function(job){
        console.log("start session", job);
        return new Promise(function(resolve, reject){
            //request.cookies = parseCookies(request); 
            if(!("id" in job.request.cookies && job.request.cookies.id.trim() != '')){
                resolve(job);
                return;
            }
            //тянем сессию
            var pg = require("pg");
            var config = require("./config");
            pg.connect(config.common.postgres, function (err, pgClient, done) {
                console.log("start session: pg connected");
	        if(err){
                    console.log(err);
                    reject();
    	            return;
	        }
                pgClient.query({
                    text: "SELECT * FROM users WHERE sid = $1;"
	           ,values: [job.request.cookies.id]
	        }, function(err, result){
                    if(err){
                        console.log(err);
                        reject();
    	                return;
                    }
                    done();
                    console.log("start session", result.rows);
                    switch(true){
	                case err:
	                    console.log(err); //не надо тут ставить break!!!
                        case result.rows.length != 1:
                            reject();
                            return;
                    }
                    job.request.user = result.rows[0];
                    console.log("session", job);
                    resolve(job);
                });
            });
        });
    }
   ,output: function(job){
        console.log("output", job);
        var mustache = require("mustache");
        job.response.writeHead(200, "Ok", job.response.habr.headers);
        "user" in job.request && (job.response.habr.data.user = job.request.user);
        var output = mustache.render(job.response.habr.pattern, job.response.habr.data, job.response.habr.patterns);
        job.response.write(output);
        job.response.end();
    }
   ,err: function(job){
        job.response.writeHead(500, "Internal Server Error", {});
        job.response.end();
    }
};
