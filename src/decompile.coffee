{Program, Def, Code} = require '../jsh/ast'
stdlib = require './corelib/stdlib'

visit = (node) ->
  deCode = new Code node.id, node.illusion
  for inputKey in Object.keys(node.input)
    deCode.push_input node.input[inputKey].toString()

  for subKey in Object.keys(node.sub)
    for sub in node.sub[subKey]
      deCode.push_sub visit(sub)

  return deCode

decompile = (program) ->
  deProgram = new Program [], []

  illusion = program.illusion
  janish = program.janish

  for node in janish
    deCode = visit(node)
    deProgram.push_code deCode

module.exports = decompile
