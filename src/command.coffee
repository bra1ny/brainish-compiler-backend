compileFile = require('./jsh').compileFile
OptParse = require 'optparse'

Switches = [
  ["-h", "--help", "Display this help information"]
]

Banner =
  """
  Usage: brainish [options] path/to/script.bysh -- [args]
  If called without options, `lucy` will run your script.
  """

Options = {
  scriptPath: null
  argv: []
}

parserOptions = () ->
  Parser = new OptParse.OptionParser Switches
  Parser.banner = Banner

  Parser.on "help", () =>
    clc.log Parser.toString()
    process.exit 0

  Parser.on 0, (val) =>
    Options.scriptPath = val
    Options.argv = process.argv.slice 3

  Parser.parse process.argv.slice(2)

exports.run = () ->
  parserOptions()
  if Options.scriptPath
    compileFile Options.scriptPath, Options.argv
  else
    Parser = new OptParse.OptionParser Switches
    Parser.banner = Banner
    console.log Parser.toString()
