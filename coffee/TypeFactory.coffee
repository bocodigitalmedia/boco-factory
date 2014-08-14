Errors = require './errors'

class TypeFactory

  constructor: (properties = {}) ->
    @constructors = properties.constructors
    @defaultConstructor = properties.defaultConstructor
    @setDefaults()

  setDefaults: ->
    @constructors ?= {}

  construct: (type, properties) ->
    Constructor = @getConstructor type, properties

    unless typeof Constructor is 'function'
      error = new Errors.ConstructorUndefined
      error.setPayload type: type
      throw error

    object = new Constructor properties
    object = @decorate object
    return object

  decorate: (object) ->
    return object

  getConstructor: (type, properties) ->
    constructor = @constructors[type]
    constructor ?= @defaultConstructor
    return constructor

  register: (constructors = {}) ->
    @constructors[name] = constructor for own name, constructor of constructors

module.exports = TypeFactory
