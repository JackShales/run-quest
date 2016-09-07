/* global angular */

(function() {
  "use strict";
  angular.module("app").controller("questCtrl", function($scope, $http) {
    $scope.setup = function() {
      $http.get('/api/v1/quests.json').then(function(response) {
        $scope.quests = response.data;
      });
    };

    $scope.sortCode = 1;
    $scope.sortRole = "assignee";

    $scope.setQuestDisplay = function(inputRole, inputStatusCode){

    };
  });
}());