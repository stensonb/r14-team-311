'use strict';

/**
 * @ngdoc function
 * @name frontendApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the frontendApp
 */
angular.module('frontendApp')
  .controller('MainCtrl',
    function ($scope, $rootScope, $state, $modal, $cookies, Restangular, notifications, Users) {
      $scope.granularities = ['monthly', 'weekly'];
      $rootScope.g = 'weekly';

      $scope.changeGranularity = function(granularity) {
        $rootScope.g = granularity;
      };
      $scope.$on('$stateChangeStart', function(event, toState){
        Users.fetchUser().then(function() {
          Users.reloadStats($rootScope.g);
          if (Users.isEmpty()) {
            if (toState.name !== 'welcome') {
              $state.transitionTo('welcome');
            }
          } else if(toState.name !== 'dashboard') {
            $state.transitionTo('dashboard')
          }
        });
      });

      notifications.checkPermissions();

      Restangular.one('sites', 'config').get().then(function(site) {
        $rootScope.site_name = site.data.name;
      });
    });
