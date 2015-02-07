fs = require 'fs'
grammar = require '../jsh/grammar'
compile = require "./compile"
decompile = require "./decompile"

compileFile = (path, argv) ->
  fs.readFile path, "utf8", (err, data) =>
    throw err if err
    console.log JSON.stringify(compile(grammar.parse(data)))

module.exports = {
  "compile": compile
  "decompile": decompile
  "compileFile": compileFile
}
