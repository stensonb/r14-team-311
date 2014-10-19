/**=========================================================
 * Module: sparkline.js
 * SparkLines Mini Charts
 =========================================================*/

'use strict';

angular.module('frontendApp').directive('sparkline', function() {
  return {
    restrict: 'A',
    link: function (scope, $element, attrs) {
      scope.$watch(attrs.sparkline, function(data) {
        scope.statsData = data;
        $element.sparkline(scope.statsData, options);
      }, true);

      var options = $element.data();

      options.type = options.type || 'bar'; // default chart is bar
      options.disableHiddenCheck = true;

      if(options.resize) {
        $(window).resize(function(){
          $element.sparkline(scope.statsData, options);
        });
      }
    }
  };

});
