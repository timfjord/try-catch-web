angular.module('try-catch').directive 'listing', ->
  restrict: 'A'
  replace: true
  scope:
    items: '=listing'
    newItem: '='
    path: '@'
  templateUrl: 'listing.html'
  controller: ($scope, $window) ->
    $scope.forms = create: {}, update: {}

    $scope.add = ->
      $scope.sending = true
      $scope.newItem.save().then ->
        $scope.items.push angular.copy($scope.newItem)
        $scope.newItem.name = ''
        $scope.forms.create.$setPristine()
      .finally $scope.sending = false

    $scope.href = (item) ->
      if $scope.path
        "#{$scope.path}/#{item.id}"
      else
        ''

    $scope.edit = (item, event) ->
      event.preventDefault()
      item.editMode = true

    $scope.reset = (item) ->
      $scope.forms.update.$setPristine()
      item.editMode = false

    $scope.update = (item) ->
      $scope.sending = true
      item.save().then ->
        $scope.reset item
      .finally $scope.sending = false

    $scope.delete = (item, event, index) ->
      event.preventDefault()
      if $window.confirm 'Are you sure?'
        item.delete().then ->
          $scope.items.splice index, 1
