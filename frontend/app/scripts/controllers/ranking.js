'use strict';

/**
 * @ngdoc function
 * @name frontendApp.controller:RankingCtrl
 * @description
 * # RankingCtrl
 * Controller of the frontendApp
 */
angular.module('frontendApp')
  .controller('RankingCtrl', function ($scope, Restangular) {
    Restangular.all('users').getList().then(function(users) {
      $scope.leader = users[0];

      Restangular.one('user_stats', $scope.leader.login).getList('monthly').then(function(stats){
        $scope.leaderStats = stats[stats.length-1];
      });

      if (users.length > 1) {
        $scope.rest = users.slice(1, users.length);
      }
    });
  });
