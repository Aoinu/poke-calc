var gulp    = require("gulp"),
  webserver = require("gulp-webserver"),
  config    = require("../../config");

gulp.task("webserver", function() {
   //Webサーバーのルートディレクトリを指定
  gulp.src([config.dest, config.src])
  .pipe(webserver({
    livereload: true, //ライブリロードを有効
    port      : 8000
  }));
});
