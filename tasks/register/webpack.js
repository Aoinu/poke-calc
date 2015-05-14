var gulp    = require("gulp");
var webpack = require("gulp-webpack");
var config  = require("../config/webpack");

gulp.task("webpack", function() {
  var array  = [];
  for (var i in config.entry) {
    array[i] = config.entry[i];
  }
  gulp.src(array)
    .pipe(webpack(config.dev))
    .pipe(gulp.dest(config.dev.output.path));
});
gulp.task("webpack:prod", function() {
  var array  = [];
  for (var i in config.entry) {
    array[i] = config.entry[i];
  }
  gulp.src(array)
    .pipe(webpack(config.prod))
    .pipe(gulp.dest(config.prod.output.path));
});
