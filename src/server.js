const http = require('http');
const createApp = require('./app');

const PORT = process.env.PORT || 8080;

const app = createApp();
const server = http.createServer(app);

server.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running on port ${PORT}`);
});
