Errors = require './errors'

class TypeFactory

  constructor: (properties = {}) ->
    @constructors = properties.constructors
    @setDefaults()

  setDefaults: ->
    @constructors ?= {}

  construct: (type, properties) ->
    Constructor = @selectConstructor type

    unless typeof Constructor is 'function'
      error = new Errors.ConstructorUndefined
      error.setPayload type: type
      throw error

    object = new Constructor properties
    object = @decorate object
    return object

  decorate: (object) ->
    return object

  selectConstructor: (type) ->
    @constructors[type]

  register: (constructors = {}) ->
    @constructors[name] = constructor for own name, constructor of constructors

module.exports = TypeFactory
