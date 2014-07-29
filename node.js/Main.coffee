

#create a server
http = require('http')
myserver = http.createServer((request, response) ->
	response.writeHead(200)
	response.write("HELLO")
	response.end()
	return
)
myserver.listen(3000);