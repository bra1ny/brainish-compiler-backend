{Program, Def, Code} = require '../jsh/ast'
stdlib = require './corelib/stdlib'

visit = (node) ->
  inputs = []
  subs = []
  
  for inputKey in Object.keys(node.input)
    inputs.push node.input[inputKey].toString()

  if node.sub != null && node.sub != undefined
    console.log node.sub.body
    for subKey in Object.keys(node.sub)
      for sub in node.sub[subKey]
        subs.push visit(sub)

  deCode = new Code node.id, node.illusion, inputs, subs
  return deCode

decompile = (program) ->
  deProgram = new Program [], []

  illusion = program.illusion
  janish = program.janish

  for node in janish
    deCode = visit(node)
    deProgram.push_code deCode
  num = 0
  console.log deProgram.deapply(num)


      
      
    
module.exports = decompile
