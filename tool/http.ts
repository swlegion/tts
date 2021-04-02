import http from 'http';

http
  .createServer((request, response) => {
    let data = '';
    request.on('data', (chunk) => {
      data += chunk;
    });
    request.on('end', () => {
      console.log(request.method, request.url, request.headers, data);
      response.writeHead(200);
      response.end();
    });
  })
  .listen(3030);

console.log(`Server running at *:3030`);
