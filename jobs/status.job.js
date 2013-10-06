var yaml = require('js-yaml');
var md5 = require('MD5');
var _ = require('lodash');
var moment = require('moment');
require('shellscript').globalize();

var cpu_points = [];
for (var i = 1; i <= 10; i++) {
  cpu_points.push({x: i, y: 0});
}
var last_x = cpu_points[cpu_points.length - 1].x;

setInterval(function() {
  var status = yaml.safeLoad($('starphleet-status'));
  cpu_points.push({x: ++last_x, y: Math.round(100 - status.free_cpu)});
  send_event('cpu', {points: cpu_points});
  send_event('ram', {value: Math.round(100 - status.free_ram)});
  send_event('disk', {value: Math.round(100 - status.free_disk)});

  _.each(status.orders, function(order) {
   order.avatar_url = "http://www.gravatar.com/avatar/" + md5(order.author);
   order.at = moment(order.at * 1000).fromNow();
  });
  send_event('orders', {items: status.orders});
  console.log(status);
}, 1 * 1000);