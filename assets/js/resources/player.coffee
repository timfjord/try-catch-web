angular.module('try-catch').factory 'Player', (RailsResource) ->
  class Player extends RailsResource
    @configure
      url: '/players'
      name: 'player'

    @build: -> @$get @$url({}, 'build')

    create: ->
      @$post "/teams/#{@teamId}/players", this
