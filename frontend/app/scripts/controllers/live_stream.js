'use strict';

/**
 * @ngdoc function
 * @name frontendApp.controller:LiveStreamCtrl
 * @description
 * # LiveStreamCtrl
 * Controller of the frontendApp
 */
angular.module('frontendApp')
  .controller('LiveStreamCtrl', function ($scope, $timeout, Restangular) {
    (function tick() {
      Restangular.all('events').getList().then(function(events) {
        $scope.events = events;
        $timeout(tick, 1000);
      });
    })();
  });
