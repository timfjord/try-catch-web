angular.module('try-catch').controller 'TeamController', ($rootScope, $scope, Player, team) ->
  $rootScope.page = title: team.name, back: '/'

  Player.build().then (player) ->
    $scope.item = player
    $scope.item.teamId = team.id

  team.getPlayers().then (players) ->
    $scope.items = players
