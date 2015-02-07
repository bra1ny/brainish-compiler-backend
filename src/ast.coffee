class BrainStatement
  constructor: () ->

  apply: () ->

class Program extends BrainStatement
  constructor: (@defs, @codes) ->

  push_def: (def) ->
    if @defs?
      @defs = []
    @defs.push def

  push_code: (code) ->
    if @codes?
      @codes = []
    @codes.push code

  apply: () ->
    ret = {
      "defs": []
      "codes": []
    }
    if @defs?
      for def in @defs
        ret.defs.push def.apply()

    if @codes?
      for code in @codes
        ret.codes.push code.apply()
    return ret

class Def extends BrainStatement
  constructor: (@type, @inputs, @outpus, @bash) ->

  apply: () ->
    ret = {
      "type": @type
      "inputs": []
      "outputs": []
      "bash": @bash
    }
    if @inputs?
      for input in @inputs
        ret.inputs.push input.toString()

    if @outputs?
      for output in @outputs
        ret.outputs.push output.toString()

    return ret

class Code extends BrainStatement
  constructor: (@id, @type, @inputs, @subs) ->

  push_input: (input) ->
    if @inputs?
      @inputs = []
    @inputs.push input

  push_sub: (sub) ->
    if @subs?
      @subs = []
    @subs.push sub

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
  Program: Program
  Def: Def
  Code: Code
}
