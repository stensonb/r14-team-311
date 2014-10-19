'use strict';

/**
 * @ngdoc function
 * @name frontendApp.controller:RankingCtrl
 * @description
 * # RankingCtrl
 * Controller of the frontendApp
 */
angular.module('frontendApp')
  .controller('RankingCtrl', function ($scope, $rootScope, Restangular) {
    function getLeaderStats() {
      if ($scope.leader) {
        Restangular.one('user_stats', $scope.leader.login).getList($rootScope.g).then(function(stats){
          $scope.leaderStats = stats[stats.length-1];
        });
      }
    }

    $rootScope.$watch('g', function () {
      getLeaderStats();
    });

    Restangular.all('users').getList().then(function(users) {
      $scope.leader = users[0];

      getLeaderStats();

      if (users.length > 1) {
        $scope.rest = users.slice(1, users.length);
      }
    });
  });
