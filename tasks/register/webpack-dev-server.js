var gulp             = require("gulp");
var gutil            = require("gulp-util");
var WebpackDevServer = require("webpack-dev-server");
var webpack          = require("webpack");
var webpackConfig    = require("../config/webpack");
var config           = require("../../config");


gulp.task("webpack-dev-server", function(callback) {
  // Start a webpack-dev-server
  new WebpackDevServer(webpack(webpackConfig.dev), {
    // server and middleware options
    watchDelay : 300,
    hot        : true,
    inline     : true,
    contentBase: "http://localhost:8000",
    publicPath : "http://localhost:8080/js/",


  }).listen(8080, "localhost", function(err) {
    if (err) throw new gutil.PluginError("webpack-dev-server", err);
    // Server listening
    gutil.log("[webpack-dev-server]", "http://localhost:8080/webpack-dev-server/index.html");

    // keep the server alive or continue?
    // callback();
  });
});
