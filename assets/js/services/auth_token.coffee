angular.module('try-catch').service 'AuthToken', ($localStorage, $window) ->
  storage = $localStorage
  tokenName = 'basicAuthToken'

  @generate = (email, password) ->
    storage[tokenName] = $window.btoa "#{email}:#{password}"

  @get = -> storage[tokenName]

  @delete = -> delete storage[tokenName]

  return
