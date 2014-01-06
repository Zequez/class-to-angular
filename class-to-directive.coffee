'use strict'
  
window.classToDirective = (constructor)->
  # We stablish if there is a previous link method
  explicitLinkExists = typeof constructor.link == 'function'

  # We determine the name of the directive
  ########################################

  # If .directive is set as a class variable, we take that as the name
  if constructor.directive?
    name = constructor.directive
  else
    # Otherwise, we read  the name from the class name

    # If the class is named 'SomethingDirective' we take Something
    stringConstructor = constructor.toString()
    name = stringConstructor.match(/^function ([^\n]+)Directive/)

    if name
      name = name[1]
    else
      # Otherwise, we take the complete name of the class
      name = stringConstructor.match(/^function ([^\n]+\()/)
      if name
        name = name[1]

    name = name.charAt(0).toLowerCase() + name.slice(1)

  # For some reason Angular doesn't accept a function with methods
  # as a valid directive object, so we have to create one, and copy
  # the class methods.
  directiveReturn = {}
  
  # We copy the class variables and methods
  # This includes things like `restrict`, or `template`
  for attr of constructor
    directiveReturn[attr] = constructor[attr]
    
  # We read the injections required
  #################################
  
  injectionRequested = constructor.inject? and constructor.inject.length?
  if injectionRequested
    # This is the list of the injected objects that is usually
    # given to the function passed to the Angular directive method
    injections = []
    
    # This is the object that is going to be passed to the
    # directive as an explicit injection. It has the names of modules
    # to be injected, plus the directive function.
    # We copy the modules we want to inject from
    # constructor#inject
    explicitInjections = (injection for injection in constructor.inject)
    
    # Now we add the function and we extract the injected modules
    # into injections, so we can then use them on the link function
    explicitInjections.push (injected...)->
      injections = injected
      directiveReturn
  else
    explicitInjections = -> directiveReturn
  
  # We define a custom link method for the directive
  ##################################################
  
  directiveReturn.link = (scope, element, attrs)->
    # Now we copy the instance variables and methods
    # This assignment is already done each time the link method is called
    # So there is no much loss in performance here.
    for attr of constructor.prototype
      scope[attr] = constructor.prototype[attr]
    
    # We add the injected modules to the scope
    # The drawback is that now it can be accessed
    # from the views
    if injectionRequested
      for injectionName, i in constructor.inject
        scope[injectionName] = injections[i]
      
    # We call the constructor, but replacing `this` with `scope`
    # We are actually not treating it as a `class`. But neither does
    # Angular use `prototype` for the scope, so there is no loss in
    # performance in that way. And no gain. I think.
    constructor.apply(scope, [element, attrs])
    
    # And now, we execute the old link function, in case you want to
    # do mysterious stuff.
    if explicitLinkExists
      constructor.link(scope, element, attrs) 
      
  # And we return the object that is passed directly to
  # the directive method
  [name, explicitInjections]