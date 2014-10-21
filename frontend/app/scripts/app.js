'use strict';

/**
 * @ngdoc overview
 * @name frontendApp
 * @description
 * # frontendApp
 *
 * Main module of the application.
 */
angular
  .module('frontendApp', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch',
    'ui.bootstrap',
    'ui.router',
    'restangular'
  ])
  .config(function ( $stateProvider, $urlRouterProvider, $rootScopeProvider) {
    $urlRouterProvider.otherwise('/');

    $stateProvider
      .state('main', {
        url: '/'
      })
      .state('welcome', {
        url: '/welcome',
        templateUrl: 'views/welcome.html',
        controller: 'WelcomeCtrl'
      })
      .state('dashboard', {
        url: '/dashboard',
        templateUrl: 'views/dashboard.html',
        controller: 'DashboardCtrl'
      });
  })
  .config(function(RestangularProvider, serverUrl) {
    if (serverUrl.length > 0) {
      RestangularProvider.setBaseUrl(serverUrl);
    }

    RestangularProvider.setRestangularFields({
      id: '_id'
    });

    RestangularProvider.setRequestInterceptor(function(elem, operation, what) {
      if (operation === 'put') {
        elem._id = undefined;
      }
      var wrapper;
      if (operation === 'post' || operation === 'put' ||  operation === 'patch') {
        wrapper = {};
        if (what[what.length - 1] === 's') {
          wrapper[what.substring(0, what.length - 1)] = elem;
        } else {
          wrapper = elem;
        }
      }
      return wrapper;
    });

    RestangularProvider.setResponseExtractor(function(response, operation) {
      var newResponse;
      if (operation === 'getList') {
        newResponse = response.data;
        if (response.metadata) {
          newResponse.metadata = response.metadata;
        }
      } else {
        newResponse = response;
      }
      return newResponse;
    });
  });
