grammar = require '../jsh/grammar'

brainish =
  """
  ls : LS ();
  for_each : FOR_EACH (ls.fileList1, ls.fileList2) {

  }
  """

program = grammar.parse(brainish)
console.log JSON.stringify(program)
