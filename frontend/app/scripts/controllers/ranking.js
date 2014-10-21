'use strict';

/**
 * @ngdoc function
 * @name frontendApp.controller:RankingCtrl
 * @description
 * # RankingCtrl
 * Controller of the frontendApp
 */
angular.module('frontendApp')
  .controller('RankingCtrl', function ($scope, $rootScope, Restangular, Users) {
    Users.fetchUser().then(function() {
      Users.reloadStats($rootScope.q);
    });
    $scope.stats = Users.stats;

    var achievements = {};
    Restangular.one('achievements', 'types').getList().then(function(types) {
      for (var i = 0; i < types.length; i++) {
        var a = types[i];
        achievements[a.id] = {
          icon: a.image_url,
          label: a.name,
          description: a.description
        };
      }
    });

    $scope.getAchievementIcon = function(id) {
      return (achievements[id]||{}).icon;
    };

    $scope.getAchievementLabel = function(id) {
      return (achievements[id]||{}).label;
    };

    $scope.getAchievementDescription = function(id) {
      return (achievements[id]||{}).description;
    };
    $scope.users = Users.users();

    $rootScope.$watch('g', function (g) {
      Users.reloadStats(g);
    });

    $scope.fromNow = function (date) {
      return moment(date).fromNow();
    };
  });
