"use strict";angular.module("frontendApp",["ngAnimate","ngCookies","ngResource","ngRoute","ngSanitize","ngTouch","ui.bootstrap","ui.router","restangular"]).config(["$stateProvider","$urlRouterProvider",function(a,b){b.otherwise("/"),a.state("dashboard",{url:"/",templateUrl:"views/main.html",controller:"MainCtrl"})}]),angular.module("frontendApp").controller("MainCtrl",["$scope",function(a){a.awesomeThings=["HTML5 Boilerplate","AngularJS","Karma"]}]),angular.module("frontendApp").controller("StatsCtrl",["$scope",function(a){a.awesomeThings=["HTML5 Boilerplate","AngularJS","Karma"]}]),angular.module("frontendApp").controller("RankingCtrl",["$scope",function(a){a.awesomeThings=["HTML5 Boilerplate","AngularJS","Karma"]}]),angular.module("frontendApp").controller("LiveStreamCtrl",["$scope",function(a){a.awesomeThings=["HTML5 Boilerplate","AngularJS","Karma"]}]),angular.module("frontendApp").directive("sparkline",function(){return{restrict:"A",link:function(a,b){var c=b.data();c.type=c.type||"bar",c.disableHiddenCheck=!0,b.sparkline("html",c),c.resize&&$(window).resize(function(){b.sparkline("html",c)})}}});