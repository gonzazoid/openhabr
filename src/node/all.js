var http = require("http");

var worker = function(request, response){
    response.write("hella!!!");
    response.end();
};

http.createServer(worker).listen(7500, "localhost");
console.log('views.server running at http://localhost:7500');
