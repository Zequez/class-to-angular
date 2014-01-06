'use strict'

app = angular.module('ClassApp', [])

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

app.directive classToDirective(BananaSplitDirective)...

class ThisIsWhateverClassName
  @directive: 'customDirectiveName'
  @restrict: 'E'

  isThisAmazing: "Yes, it's so simple, yet so awesome!"

  constructor: ->
    @isThisAmazing = 'YES!'

app.directive classToDirective(ThisIsWhateverClassName)...