config         = require("../../config");

module.exports = {
  src     : [
      config.src + "/views/**/!(_)*.jade",
      "!"+config.src + "/views/**/layout.jade"
  ],
  dest    : config.dest,
  options : {
    pretty: true
  }
};
