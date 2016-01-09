"use strict";
//просто что бы видеть, какие модули используются
["http", "fs", "pg", "mustache", "./bike", "./config"].forEach(cV => require(cV));

var fs = require("fs");
var http = require("http");

var patterns = {
    some_pattern: fs.readFileSync("./tpl/some_pattern.tpl", "utf-8")
   ,footer: fs.readFileSync("./tpl/footer.tpl", "utf-8")
};

var dispatcher = function(request, response){

    var fw = require("./bike");

         fw.prepare_headers({request, response})
   .then(fw.parse_cookies, fw.err)
   .then(fw.start_session, fw.err)
   .then(worker, fw.err)
   .then(fw.output, fw.err);
};

var worker = function(job){
    console.log("worker", job);
    return new Promise(function(resolve, reject){
        //TODO перевести на pg-then
        var pg = require("pg");
        var config = require("./config");

    });
};

http.createServer(dispatcher).listen(????, "localhost");
console.log('????.server running at http://localhost:????');
