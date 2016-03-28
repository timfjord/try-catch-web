angular.module('try-catch').controller 'TeamsController', ($rootScope, $scope, $location, Team, teams) ->
  $rootScope.page = title: 'All teams'

  $scope.path = '/teams'
  $scope.items = teams

  Team.build().then (team) ->
    $scope.item = team
