//
// gulpfile.js
//

var gulp       = require("gulp");
var requireDir = require("require-dir");
var dir        = requireDir("./tasks", {
  recurse: true
});
var path       = require("path");


//default task
gulp.task("default", ["jade", "webserver", "webpack", "watch", "webpack-dev-server"]);

gulp.task("build", ["jade:prod", "webpack:prod"]);
