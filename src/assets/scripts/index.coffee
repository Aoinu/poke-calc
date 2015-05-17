require '../includes/pokeModel'
require 'angular-material'
romaji = require 'romaji'

app = angular.module 'myApp',['poke-calc','ngMaterial']
app.controller 'poke-calcController',['$scope','pokeModel',($scope,pm)->
  updateStat = (index)->
    tmp = Math.floor(
      pm.baseStats[index]*2 +
      pm.individualValue[index] +
      pm.effortValue[index]/4
    )
    tmp = Math.floor(tmp * pm.level/100)
    if index is 0
      pm.stats[index] = tmp + 10 + pm.level
    else
      natIndex = pm.pokeData.natName.indexOf pm.nature
      if natIndex isnt -1
        pm.stats[index] = Math.floor(
          (tmp+5)*pm.pokeData.natCorrection[natIndex][index-1]
        )
      else
        return null

  $scope.pokeModel = pm
  $scope.updateStat = updateStat
  $scope.updateStats = ->
    for i in [0...6]
      updateStat i
  $scope.updateBaseStats = ->
    index = pm.pokeData.pokeName.indexOf pm.name
    console.log index
    if index isnt -1
      pm.baseStats = pm.pokeData.pokeBaseStats[index]

  $scope.getMatcheNames = (searchText)->
    searchText = romaji.toKatakana searchText
    re = new RegExp searchText
    return pm.pokeData.pokeName.filter (element,index,array)->
      if element.match re
        return true
      else
        return false



]
