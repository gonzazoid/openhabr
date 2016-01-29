"use strict";
//просто что бы видеть, какие модули используются
["http", "fs", "pg", "url", "mustache", "./bike", "./config"].forEach(cV => require(cV));

var fs = require("fs");
//var http = require("http");
var app = require("express")();
var fw = require("./bike");
var cookies = require("cookie-parser");
var bodyParser = require("body-parser");

var patterns = {

};

app.use(fw.prepare_headers)
   .use(cookies())
   .use(fw.start_session)
   .use(bodyParser.urlencoded({extended:true}))
   .get("/comment/", function(req, res){
        console.log(req);
    })

.listen(7506, "localhost", undefined,() => console.log('comment.server running at http://localhost:7506'));
