'use strict';

/**
 * @ngdoc function
 * @name frontendApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the frontendApp
 */
angular.module('frontendApp')
  .controller('MainCtrl', function ($scope, $modal) {
    $scope.openAbout = function() {
      $modal.open({
        templateUrl: 'views/about.html',
        controller: function($scope, $modalInstance) {
          $scope.close = function() {
            $modalInstance.dismiss('cancel');
          };
        }
      });
    };
  });
