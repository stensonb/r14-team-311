/**=========================================================
 * Module: sparkline.js
 * SparkLines Mini Charts
 =========================================================*/

'use strict';

angular.module('frontendApp').directive('sparkline', function() {
  return {
    restrict: 'A',
    link: function ($scope, $element) {
      var options = $element.data();

      options.type = options.type || 'bar'; // default chart is bar
      options.disableHiddenCheck = true;

      $element.sparkline('html', options);

      if(options.resize) {
        $(window).resize(function(){
          $element.sparkline('html', options);
        });
      }
    }
  };

});
