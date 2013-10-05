var forever = require('forever-monitor');

var child = new (forever.Monitor)('server.js', {
  max: 1024*1024,
  silent: true,
  options: [],
  outFile: '/dev/stdout',
  errFile: '/dev/stderr'
});

child.on('exit', function () {
  console.log('exited');
});

console.log('running forever');
child.start();
