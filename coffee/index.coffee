class Factory

  constructor: (properties = {}) ->
    @constructors = properties.constructors
    @setDefaults()

  setDefaults: ->
    @constructors = {} unless @constructors?

  construct: (name, properties = {}) ->
    constructor = @getConstructor name
    return new constructor(properties)

  register: (constructors = {}) ->
    @constructors[name] = constructor for own name, constructor of constructors

  getConstructor: (name) ->
    @constructors[name]

  isRegistered: (name) ->
    @constructors.hasOwnProperty name

exports.Factory = Factory
