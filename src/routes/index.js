const { Router } = require('express');
const os = require('os');

const router = Router();

router.get('/', (req, res) => {
  res.type('text').send(`Hello World from Fly.io! Host: ${os.hostname()}`);
});

router.get('/api/hello', (req, res) => {
  res.json({ message: 'Hello World' });
});

module.exports = router;
