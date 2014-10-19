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
    $scope.stats = {};
    function getUserStats(users) {
      for (var i = 0; i < users.length; i++) {
        var user = users[i];
        Restangular.one('user_stats', user.login).getList($rootScope.g).then(function(stats){
          $scope.stats[stats[0].login] = stats[0];
        });
      }
    }

    var icons = {};
    var labels = {};
    Restangular.one('achievements', 'types').getList().then(function(types) {
      for (var i = 0; i < types.length; i++) {
        var achievement = types[i];
        icons[achievement.id] = achievement.image_url;
        labels[achievement.id] = achievement.name;
      }
    });

    $scope.getAchievementIcon = function(id) {
      return icons[id];
    };

    $scope.getAchievementLabel = function(id) {
      return labels[id];
    };

    $rootScope.$watch('g', function () {
      if ($scope.users) {
        getUserStats($scope.users);
      }
    });

    Restangular.all('users').getList().then(function(users) {
      $scope.users = users;
      getUserStats($scope.users);
    });

    $scope.fromNow = function (date) {
      return moment(date).fromNow();
    };
  });
