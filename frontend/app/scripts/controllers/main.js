'use strict';

/**
 * @ngdoc function
 * @name frontendApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the frontendApp
 */
angular.module('frontendApp')
  .controller('MainCtrl', function ($scope, $rootScope, $modal, $cookies) {
    $scope.granularities = ['monthly', 'weekly'];
    $rootScope.g = 'weekly';

    $scope.changeGranularity = function(granularity) {
      $rootScope.g = granularity;
    };

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

    if ($cookies.fr !== '1') {
      $scope.openAbout();
      $cookies.fr = '1';
    }
  });
