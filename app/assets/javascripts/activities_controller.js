/* global angular */

(function() {
  "use strict";
  angular.module("app").controller("activityCtrl", function($scope, $http) {
    $scope.setup = function() {
      $http.get('/api/v1/activities.json').then(function(response) {
        console.log(response.data);
        $scope.activities = response.data;
      });
    };
  });
}());