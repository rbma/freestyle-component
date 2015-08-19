'use strict'

angular
  .module('rbmaSushiSequencer', [])
  .controller 'SushiSequencerController', ($scope, Couchdb) ->
    Couchdb.getSearchView 'search', 'multiSearch', q: 'type:sushiSequencer', include_docs: true, true
      .then (resp) ->
        $scope.artists = resp.data.rows[0].doc.artists