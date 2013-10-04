
var fs = require('fs');
setInterval(function() {
  var free = parseFloat(fs.readFileSync('/var/starphleet/diagnostic/free_ram'));
  var used = 100 - free;
  send_event('ram', {value: Math.floor(used)});
}, 5 * 1000);
