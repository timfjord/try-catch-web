angular.module 'try-catch', ['ngRoute', 'templates', 'constants', 'rails', 'ngStorage']
  .config ($routeProvider, $locationProvider) ->
    $locationProvider.html5Mode true

    $routeProvider
      .when '/',
        templateUrl: 'index.html'
        controller: 'TeamsController'
        resolve:
          teams: (Team) -> Team.query()

      .when '/teams/:id',
        templateUrl: 'index.html'
        controller: 'TeamController'
        resolve:
          team: ($q, $route, Team) ->
            if $route.current.params.id
              Team.get $route.current.params.id
            else
              $q.reject()

      .when '/sign_in',
        templateUrl: 'login.html'
        controller: 'LoginController'

      .otherwise
        redirectTo: '/'

    return

  .config ($httpProvider) ->
    $httpProvider.interceptors.push (AuthToken, ENV) ->
      makeUrl = (domain, url)->
        ('' + domain).replace(/\/*$/, '') + '/' + url.replace(/^\/*/, '')

      'request': (config) ->
        if token = AuthToken.get()
          config.headers['Authorization'] = "Basic #{token}"

        unless /\.html$/.test config.url
          config.url = makeUrl ENV['HOST'], config.url

        config

    $httpProvider.interceptors.push ($q, $rootScope) ->
      'responseError': (rejection) ->
        $rootScope.$broadcast 'session:unauthorized' if rejection.status == 401
        $q.reject rejection

  .run ($rootScope, $location, $http) ->
    $rootScope.$on 'session:unauthorized', -> $location.path '/sign_in'
