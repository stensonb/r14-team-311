'use strict';

/**
 * @ngdoc function
 * @name frontendApp.controller:StatsCtrl
 * @description
 * # StatsCtrl
 * Controller of the frontendApp
 */
angular.module('frontendApp')
  .controller('StatsCtrl', function ($scope, $rootScope, Restangular) {
    var before;
    $scope.cStat = 'points';
    $scope.stats = [];

    function createFakeStats() {
      return {
        assigned_issues: Math.round(Math.random()*20),
        closed_issues: Math.round(Math.random()*20),
        closed_pull_request: Math.round(Math.random()*20),
        commits: Math.round(Math.random()*20),
        opened_issues: Math.round(Math.random()*20),
        opened_pull_request: Math.round(Math.random()*20),
        opened_pull_requests: Math.round(Math.random()*20),
        points: Math.round(Math.random()*20),
        pushes: Math.round(Math.random()*20),
        collaborators: Math.round(Math.random()*20)
      };
    }

    function getStats() {
      Restangular.one('stats', $rootScope.g).getList().then(function(stats){
        $scope.stats = stats;
        $scope.current = $scope.stats[$scope.stats.length-1];
        before = $scope.stats[$scope.stats.length-2];
        if ($scope.stats.length <= 1) {
          before = createFakeStats();
          $scope.stats.unshift(before);
          $scope.stats.unshift(createFakeStats());
          $scope.stats.unshift(createFakeStats());
          $scope.stats.unshift(createFakeStats());
        }
      });
    }

    $rootScope.$watch('g', function () {
      getStats();
    });

    getStats();

    $scope.extractData = function(key) {
      var rs = [];
      for (var i = 0; i < $scope.stats.length; i++) {
        var stat = $scope.stats[i];
        rs.push(stat[key]||0);
      }
      return rs;
    };

    $scope.getDelta = function(key) {
      if (!$scope.current) {
        return 0;
      }

      var beforeData = 0;
      if (before) {
        beforeData = before[key]||0;
      }
      var rs = $scope.current[key] - beforeData;
      if (rs > 0) {
        rs = '+ ' + rs;
      } else {
        rs = '- ' + Math.abs(rs);
      }
      return rs;
    };

    var labels = {
      assigned_issues: 'assigned issues',
      closed_issues: 'closed issues',
      closed_pull_request: 'closed pull request',
      closed_pull_requests: 'closed pull requests',
      commits: 'commits',
      opened_issues: 'opened issues',
      opened_pull_request: 'opened pull request',
      opened_pull_requests: 'opened pull requests',
      points: 'points',
      pushes: 'pushes',
      collaborators: 'collaborators'
    };

    $scope.getLabel = function(key) {
      return labels[key];
    };

    $scope.changeCstat = function(key) {
      $scope.cStat = key;
    };

    $scope.isActive = function(key) {
      return $scope.cStat === key;
    };
  });
