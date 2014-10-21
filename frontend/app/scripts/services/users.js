'use strict';

/**
 * @ngdoc service
 * @name frontendApp.users
 * @description
 * # users
 * Factory in the frontendApp.
 */
angular.module('frontendApp')
  .factory('Users', function($q, Restangular) {
    var users = [];
    var stats = {};
    function reloadStats (g) {
      for (var i = 0; i < users.length; i++) {
        Restangular.one('user_stats', users[i].login).getList(g).then(function(data){
          stats[data[0].login] = data[data.length-1];
        });
      }
    }
    // Public API here
    return {
      fetchUser: function () {
        var deferred = $q.defer();
        if (users.length === 0) {
          Restangular.all('users').getList().then(function(data) {
            users = data;
            deferred.resolve(data);
          });
        } else {
          deferred.reject();
        }
        return deferred.promise;
      },
      isEmpty: function () {
        return users.length === 0;
      },
      reloadStats: reloadStats,
      users: function () {
        return users;
      },
      stats: function (login) {
        return (stats[login] || {});
      }
    }
  });
