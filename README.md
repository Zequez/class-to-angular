ClassToAngular
==============

ClassToAngular is a an ***experimental*** tool to use CoffeeScript classes to create AngularJS directives, controllers and that kind of things.

Instead of doing:

```
angular.module('ClassApp', []).directive 'bananaSplit', ($timeout)->
  restrict: 'E'
  link: (scope, element, attrs)->
    scope.isApple = 'Is not apple'
    scope.isBanana = 'Is banana'
    scope.isOrange = 'Is orange'
    scope.callTheBananaKing = ->
      $timeout ->
        console.log 'Calling the banana king!'
        console.log 'Because: ', scope.isBanana
      , 1000

```

It may look fine for now, but start to make a bigger app and your link function gets cluttered like hell.
Besides, it doesn't look Coffeescripty at all!
Instead you can do:

```
class BananaSplitDirective
  @restrict: 'E'
  
  @inject: ['$timeout']
  
  # This gets called at the end of the new link function
  @link: (scope, element, attrs)->
    scope.isApple = 'Is not apple'
    
  # This gets assigned to the `scope`
  isBanana: "Yes, it's banana"

  # This replaces the link function
  # But instead of `scope` we can use @/this
  constructor: (element, attrs)->
    @isOrange = "No, it's not orange"
    
  # This also gets assigned to the scope.
  callTheBananaKing: ->
    @$timeout =>
      console.log 'Calling the banana king!'
      console.log 'Because: ', @isBanana
    , 1000

angular.module('ClassApp', []).directive classToDirective(BananaSplitDirective)...
```

Does it have a big performance impact? I don't think so! But I haven't tested yet, so don't take my word for granted!

The thing is, it shouldn't, since most of the extra processing is made on the startup of the application! If someone has a better and faster idea, please say so!


ToDo
===============
- Make a script for controllers and the other stuff.
- Make it work like `angular.module('ClassApp', []).classDirective BananaSplitDirective` which is nicer. 