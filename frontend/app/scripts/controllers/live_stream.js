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
    var timestamp = 0;
    (function tick() {
      Restangular.all('events').getList({timestamp: timestamp}).then(function(events) {
        for(var i = 0; i < events.length; i++) {
          var evnt = events[i];
          evnt.created_at = moment(evnt.created_at);
          if (evnt.type === 'push') {
            evnt.isCollapsed = true;
            var moreCommits = [];
            var headCommits = [];
            for(var j = 0; j < evnt.data.commits.length; j++) {
              var commit = evnt.data.commits[j];
              commit.timestamp = moment(commit.timestamp);
              if (j < 2) {
                headCommits.push(commit);
              } else {
                moreCommits.push(commit);
              }
            }
            evnt.data.more_commits = moreCommits;
            evnt.data.head_commits = headCommits;
          }
          if ($scope.events) {
            $scope.events.unshift(evnt);
          }
        }
        if (!timestamp) {
          timestamp = events[0].created_at.unix();
        }
        if (!$scope.events) {
          $scope.events = events;
        }
        $timeout(tick, 10000);
      });
    })();
  });
