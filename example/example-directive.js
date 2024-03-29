// Generated by CoffeeScript 1.6.3
(function() {
  'use strict';
  var BananaSplitDirective, ThisIsWhateverClassName, app;

  app = angular.module('ClassApp', []);

  BananaSplitDirective = (function() {
    BananaSplitDirective.restrict = 'E';

    BananaSplitDirective.inject = ['$timeout'];

    BananaSplitDirective.link = function(scope, element, attrs) {
      return scope.isApple = 'Is not apple';
    };

    BananaSplitDirective.prototype.isBanana = "Yes, it's banana";

    function BananaSplitDirective(element, attrs) {
      this.isOrange = "No, it's not orange";
    }

    BananaSplitDirective.prototype.callTheBananaKing = function() {
      var _this = this;
      return this.$timeout(function() {
        console.log('Calling the banana king!');
        return console.log('Because: ', _this.isBanana);
      }, 1000);
    };

    return BananaSplitDirective;

  })();

  app.directive.apply(app, classToDirective(BananaSplitDirective));

  ThisIsWhateverClassName = (function() {
    ThisIsWhateverClassName.directive = 'customDirectiveName';

    ThisIsWhateverClassName.restrict = 'E';

    ThisIsWhateverClassName.prototype.isThisAmazing = "Yes, it's so simple, yet so awesome!";

    function ThisIsWhateverClassName() {
      this.isThisAmazing = 'YES!';
    }

    return ThisIsWhateverClassName;

  })();

  app.directive.apply(app, classToDirective(ThisIsWhateverClassName));

}).call(this);
