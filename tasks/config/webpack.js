var config  = require("../../config");
var entry   = require("../config/entry");
var webpack = require("webpack");
var path    = require("path");

module.exports = {
  dev: {
    // configuration
    cache               : true,

    entry               : (function() {
      var valueGenerator = function(filename) {
        return config.src + "/assets/scripts/" + entry.splitext(filename);
      };
      var _entry         = entry.entryFiles(config.src + "/views", undefined, valueGenerator);
      return _entry;
    }()),

    output              : {
      path              : config.dest + "/js/",
      publicPath        : "/js/",
      filename          : "[name].js",
    },

    resolve             : {
      extensions        : ["", ".js", ".coffee",".html"],
      modulesDirectories: ['node_modules', 'bower_components'],
      root: [
        'bower_components',
        path.join(config.src ,'assets' ,'templates')
      ]
    },

    plugins             : [
      new webpack.NoErrorsPlugin(),
      new webpack.HotModuleReplacementPlugin(),
      new webpack.ResolverPlugin(
        new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin('.bower.json', ['main'])
      ),
      new webpack.optimize.DedupePlugin(),
      new webpack.ProvidePlugin({
          jQuery: "jquery",
          $: "jquery",
          jquery: "jquery",
          anguluar: "anguluar"
      })
    ],

    module              : {
      loaders           : [{
        test            : /\.coffee$/,
        loader          : "coffee"
      }]
    }
  },
  prod: {
    // configuration
    cache               : true,
    debug: false,
    stats: {
      colors: true,
      reasons: false
    },

    entry               : (function() {
      var valueGenerator = function(filename) {
        return config.src + "/assets/scripts/" + entry.splitext(filename);
      };
      var _entry         = entry.entryFiles(config.src + "/views", undefined, valueGenerator);
      return _entry;
    }()),

    output              : {
      path              : config.dest + "/js/",
      publicPath        : "/js/",
      filename          : "[name].js",
    },

    resolve             : {
      extensions        : ["", ".js", ".coffee",".html"],
      modulesDirectories: ['node_modules', 'bower_components'],
      root: [
        'bower_components',
        path.join(config.src ,'assets' ,'templates')
      ]
    },

    plugins             : [
      new webpack.ResolverPlugin(
        new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin('.bower.json', ['main'])
      ),
      new webpack.optimize.DedupePlugin(),
      new webpack.optimize.UglifyJsPlugin(),
      new webpack.optimize.OccurenceOrderPlugin(),
      new webpack.optimize.AggressiveMergingPlugin(),
      new webpack.ProvidePlugin({
          jQuery: "jquery",
          $: "jquery",
          jquery: "jquery",
          angluar: "angluar"
      })
    ],

    module              : {
      loaders           : [
        {
          test            : /\.coffee$/,
          loader          : "coffee"
        },
        {
          test            : /\.html$/,
          loader          : "html?minimize"
        }
      ]
    }
  }
};
