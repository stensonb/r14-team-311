'use strict';

describe('Controller: LiveStreamCtrl', function () {

  // load the controller's module
  beforeEach(module('appApp'));

  var LiveStreamCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    LiveStreamCtrl = $controller('LiveStreamCtrl', {
      $scope: scope
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(scope.awesomeThings.length).toBe(3);
  });
});
