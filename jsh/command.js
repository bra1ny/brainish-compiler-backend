(function() {
  var Banner, OptParse, Options, Switches, compiler, parserOptions;

  compiler = require('./jsh');

  OptParse = require('optparse');

  Switches = [["-h", "--help", "Display this help information"], ["-j", "--json", "Conmpile to JSON"]];

  Banner = "Usage: brainish [options] path/to/script.bysh -- [args]\nIf called without options, `lucy` will run your script.";

  Options = {
    toJSON: false,
    scriptPath: null,
    argv: []
  };

  parserOptions = function() {
    var Parser;
    Parser = new OptParse.OptionParser(Switches);
    Parser.banner = Banner;
    Parser.on("help", (function(_this) {
      return function() {
        console.log(Parser.toString());
        return process.exit(0);
      };
    })(this));
    Parser.on("json", (function(_this) {
      return function() {
        return Options.toJSON = true;
      };
    })(this));
    Parser.on(0, (function(_this) {
      return function(val) {
        Options.scriptPath = val;
        return Options.argv = process.argv.slice(3);
      };
    })(this));
    return Parser.parse(process.argv.slice(2));
  };

  exports.run = function() {
    var Parser;
    parserOptions();
    if (Options.toJSON) {
      return compiler.compileJSON(Options.scriptPath, Options.argv);
    } else if (Options.scriptPath) {
      return compiler.compileBash(Options.scriptPath, Options.argv);
    } else {
      Parser = new OptParse.OptionParser(Switches);
      Parser.banner = Banner;
      return console.log(Parser.toString());
    }
  };

}).call(this);
