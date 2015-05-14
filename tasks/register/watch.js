var configJade    = require("../config/jade");
var configWebpack = require("../config/webpack");
var gulp          = require("gulp");
var watch         = require("gulp-watch");

gulp.task("watch", function() {
  watch(configJade.src, function() {
    gulp.start(["jade"]);
  });
});
