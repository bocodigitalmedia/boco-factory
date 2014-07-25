# boco-factory

Classes and utilities for working with object factories.

    BocoFactory = require 'boco-factory'
    assert = require 'assert'

# Factory class

Provides a basic implementation of the [factory pattern].

    Factory = BocoFactory.Factory
    factory = new Factory()

## Registering constructors

Each factory should encapsulate the constructors for concrete classes  it maintains. Let's create a couple simple classes:

    class User
      constructor: (properties = {}) ->
        @id = properties.id
        @name = properties.name

    class Post
      constructor: (properties = {}) ->
        @id = properties.id
        @title = properties.title

To register them with our factory, we call the `register` method with an collection of key/value pairs. The key and value represent the name for our constructor and the constructor function itself, respectively.

    factory.register User: User, Post: Post

    assert factory.isRegistered 'User'
    assert factory.isRegistered 'Post'
    assert !factory.isRegistered 'Foo'

You can retrieve any of the constructors by name using the `getConstructor` method.

    assert.equal User, factory.getConstructor('User')
    assert.equal Post, factory.getConstructor('Post')


## Constructing objects

Now that we have registered some constructors, we can use our factory to create instances of those classes.

    user = factory.construct 'User', name: "john.doe"
    assert user instanceof User
    assert.equal "john.doe", user.name


# Custom factories

You may want to extend the Factory class to perform custom construction of your objects. Let's create a new Factory class that generates an identity for each object it constructs.

    class IdentifyingFactory extends Factory

      generateId: ->
        @lastId = if @lastId? then @lastId + 1 else 1

      construct: (properties = {}) ->
        object = super(properties)
        object.id = @generateId() unless object.id?
        return object

Now, let's create an instance of this factory class and register our constructors.

    factory = new IdentifyingFactory()
    factory.register User: User, Post: Post

If we construct a User and Post, they should now have an id assigned by our factory.

    post = factory.construct 'Post', title: "My first post"
    user = factory.construct 'User', name: "john.doe"

    assert.equal 1, post.id
    assert.equal 2, user.id
