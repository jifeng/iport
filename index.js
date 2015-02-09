var coffee = require('coffee-script');
if (coffee.register) {
  coffee.register();
}
module.exports = require(__dirname + '/lib/iport');
