angular.module('try-catch').controller 'MainController', ($rootScope, $scope, $location, AuthToken) ->
  $scope.isSignedIn = -> AuthToken.get()

  $scope.logout = ->
    AuthToken.delete()
    $location.path '/sign_in'
