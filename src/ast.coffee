class BrainStatement
  constructor: () ->

  apply: () ->

class Program extends BrainStatement
  constructor: (@defs, @codes) ->

  apply: () ->
    ret = {
      "defs": []
      "codes": []
    }
    if @codes?
      for code in @codes
        ret.codes.push code.apply()
    return ret

class Use extends BrainStatement
  constructor: (@id, @type, @inputs, @subs) ->

  apply: () ->
    ret = {
      "id": @id
      "type": @type
      "inputs": []
      "subs": []
    }
    if @inputs?
      for input in @inputs
        ret.inputs.push input.toString()

    if @subs?
      for sub in @subs
        ret.subs.push sub.apply()
    return ret

module.exports = {
  Use: Use
  Program: Program
}
