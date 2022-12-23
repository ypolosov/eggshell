const http = require('http');

const hostname = '0.0.0.0';
const port = 3000;
const appName = 'Backend';

const server = http.createServer((req, res) => {

    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/plain');
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.end(`Hello from '${appName}'!`);
});
server.listen(port, hostname, () => {
    console.log(`API server is running on http://${hostname}:${port}/`);
});


