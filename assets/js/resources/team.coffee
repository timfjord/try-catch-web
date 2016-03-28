angular.module('try-catch').factory 'Team', (RailsResource, Player) ->
  class Team extends RailsResource
    @configure
      url: '/teams'
      name: 'team'

    @build: -> @$get @$url({}, 'build')

    getPlayers: ->
      Player.$get @$url('players')
