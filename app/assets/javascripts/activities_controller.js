/* global angular */

(function() {
  "use strict";
  angular.module("app").controller("activityCtrl", function($scope, $http) {
    $scope.setup = function() {
      $http.get('/api/v1/activities.json').then(function(response) {
        $scope.activities = response.data;
      });
    };

    $scope.userActivity = function(inputActivity, inputUserId) {
      if (inputActivity.userId === inputUserId) {
        return true;
      }
    };

    // $scope.joinToQuest = function(inputActivity, inputQuestId) {
    //   $http.patch('/api/v1/activities/' + inputActivity.id).then(function(response) {
        
    //   });
    // };
  });
}());