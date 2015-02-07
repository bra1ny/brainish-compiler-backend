(function() {
  var compile, compileBash, compileJSON, compile_jsh, decompile, fs, grammar;

  fs = require('fs');

  grammar = require('../jsh/grammar');

  compile = require("./compile");

  compile_jsh = require("./compile_jsh");

  decompile = require("./decompile");

  compileJSON = function(path, argv) {
    return fs.readFile(path, "utf8", (function(_this) {
      return function(err, data) {
        if (err) {
          throw err;
        }
        return console.log(JSON.stringify(compile(grammar.parse(data)), null, 2));
      };
    })(this));
  };

  compileBash = function(path, argv) {
    return fs.readFile(path, "utf8", (function(_this) {
      return function(err, data) {
        if (err) {
          throw err;
        }
        return console.log(compile_jsh(compile(grammar.parse(data))));
      };
    })(this));
  };

  module.exports = {
    "compile": compile,
    "decompile": decompile,
    "compileJSON": compileJSON,
    "compileBash": compileBash
  };

}).call(this);
