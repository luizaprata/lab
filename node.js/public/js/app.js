(function() {
  var http, myserver;

  http = require('http');

  myserver = http.createServer(function(request, response) {
    response.writeHead(200);
    response.write("HELLO");
    response.end();
  });

  myserver.listen(3000);

}).call(this);

(function() {
  var http, myserver;

  http = require('http');

  myserver = http.createServer(function(request, response) {
    response.writeHead(200);
    response.write("HELLO");
    response.end();
  });

  myserver.listen(3000);

}).call(this);
