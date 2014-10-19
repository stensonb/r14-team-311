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
      $scope.rest = users.slice(0, users.length);
    });
  });
