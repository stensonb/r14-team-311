'use strict';

/**
 * @ngdoc service
 * @name frontendApp.notifications
 * @description
 * # notifications
 * Factory in the frontendApp.
 */
angular.module('frontendApp')
  .factory('notifications', function ($timeout) {

    var permission = Notification.permission;

    // Public API here
    return {
      checkPermissions: function () {
        console.log("Permission: " + permission);
        if(permission != "granted") {
          Notification.requestPermission(function(permission){
            console.log("Permission: ");
          });
        }
        return permission;
      },

      raise: function(msg) {
        var n = new Notification( "Gamegit", {
          body: msg
        });

        $timeout(function() { n.close() }, 3000);
      }
    };
  });
