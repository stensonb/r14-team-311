'use strict';

/**
 * @ngdoc function
 * @name frontendApp.controller:StatsCtrl
 * @description
 * # StatsCtrl
 * Controller of the frontendApp
 */
angular.module('frontendApp')
  .controller('StatsCtrl', function ($scope, Restangular) {
    $scope.stats = {};

    Restangular.one('stats', 'monthly').getList().then(function(stats){
      for (var i = 0; i < stats.length; i++) {
        var stat = stats[i];
        for (var k in stat) {
          $scope.stats[k] = $scope.stats[k] || [];
          $scope.stats[k].push(stat[k]);
        }
      }
      for (var key in $scope.stats) {
        var s = $scope.stats[key];
        if (s.length <= 1) {
          $scope.stats[key].unshift(0);
        }
      }
    });
  });
