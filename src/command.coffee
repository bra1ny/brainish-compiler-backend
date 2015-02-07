compiler = require './jsh'
OptParse = require 'optparse'

Switches = [
  ["-h", "--help", "Display this help information"]
  ["-j", "--json", "Conmpile to JSON"]
]

Banner =
  """
  Usage: brainish [options] path/to/script.bysh -- [args]
  If called without options, `lucy` will run your script.
  """

Options = {
  toJSON: false
  scriptPath: null
  argv: []
}

parserOptions = () ->
  Parser = new OptParse.OptionParser Switches
  Parser.banner = Banner

  Parser.on "help", () =>
    console.log Parser.toString()
    process.exit 0

  Parser.on "json", () =>
    Options.toJSON = true

  Parser.on 0, (val) =>
    Options.scriptPath = val
    Options.argv = process.argv.slice 3

  Parser.parse process.argv.slice(2)

exports.run = () ->
  parserOptions()
  if Options.toJSON
    compiler.compileJSON Options.scriptPath, Options.argv
  else if Options.scriptPath
    compiler.compileBash Options.scriptPath, Options.argv
  else
    Parser = new OptParse.OptionParser Switches
    Parser.banner = Banner
    console.log Parser.toString()
