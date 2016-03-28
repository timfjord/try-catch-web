angular.module('try-catch').controller 'LoginController', ($rootScope, $scope, $location, $http, AuthToken) ->
  $rootScope.page = title: 'Sign in'

  $scope.data = user: {}
  $scope.forms = login: {}
  $scope.sending = false

  $scope.login = ->
    $scope.sending = true
    $http.post('/users/sign_in', $scope.data).then ->
      AuthToken.generate $scope.data.user.email, $scope.data.user.password
      $location.path '/'
    , ->
      $scope.forms.login.email.$setValidity 'required', false
    .finally -> $scope.sending = false
