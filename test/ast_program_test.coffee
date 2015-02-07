{Use, Program} = require '../jsh/ast'

exports.testProgram = (test) ->
  _ls = new Use "ls", "LS", ["."]
  _for = new Use "for", "FOR", ["ls.fileList"], [
    new Use "echo", "ECHO", ["for.itertor"]
  ]
  _program = new Program "null", [_ls, _for]
  compile = _program.apply()
  test.equal 0, compile.defs.length
  test.equal 2, compile.codes.length
  test.done()
