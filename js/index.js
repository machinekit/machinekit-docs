var protoNames = require('../build/js/protonames.json');

protoNames.forEach(function(proto) {
  module.exports[proto.name] = require('../build/js/' + proto.fullname + '.js').pb;
});
