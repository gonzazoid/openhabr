var http = require("http");
var fs = require("fs");
var pg = require("pg");
var mustache = require("mustache");

var pattern = fs.readFileSync("./tpl/all.tpl");

var worker = function(request, response){
        var headers = {};

        headers['Content-Type'] = 'application/json';
        headers['Expires'] = 'Mon, 26 Jul 1997 05:00:00 GMT'; //Дата в прошлом 
        headers['Cache-Control'] = ' no-cache, must-revalidate'; // HTTP/1.1 
        headers['Pragma'] = ' no-cache'; // HTTP/1.1 
        //headers['Last-Modified'] = ".gmdate("D, d M Y H:i:s")."GMT");

        response.writeHead(200, "Ok", headers);
    response.write(pattern);
    response.end();
};

http.createServer(worker).listen(7500, "localhost");
console.log('views.server running at http://localhost:7500');
