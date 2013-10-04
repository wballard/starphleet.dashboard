//CPU meter, reading idle time from disk to figure the active time
var fs = require('fs');

var points = [];
for (var i = 1; i <= 10; i++) {
  points.push({x: i, y: 0});
}
var last_x = points[points.length - 1].x;

setInterval(function() {
  var idle = parseFloat(fs.readFileSync('/var/starphleet/diagnostic/idle_cpu'));
  var active = Math.round(100 - idle);
  console.log(active, idle);
  points.shift();
  points.push({x: ++last_x, y: active});
  console.log(points);
  send_event('cpu', {points: points});
}, 5 * 1000);

