require '../includes/pokeModel'
require 'angular-material'
romaji = require 'romaji'
ZeroClipboard = require 'zeroclipboard'

app = angular.module 'myApp',['poke-calc','ngMaterial']
app.controller 'poke-calcController',
['$scope','$mdToast','pokeModel',($scope,$mdToast,pm)->
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

  mezapa = [
    ['あく','ドラゴン','ドラゴン','ドラゴン','ドラゴン','こおり','こおり','こおり']
    ['こおり','エスパー','エスパー','エスパー','エスパー','でんき','でんき','でんき']
    ['でんき','くさ','くさ','くさ','くさ','くさ','みず','みず']
    ['みず','みず','ほのお','ほのお','ほのお','ほのお','ほのお','はがね']
    ['はがね','はがね','ゴースト','ゴースト','ゴースト','ゴースト','むし','むし']
    ['むし','むし','むし','いわ','いわ','いわ','いわ','じめん']
    ['じめん','じめん','じめん','どく','どく','どく','どく','ひこう']
    ['ひこう','ひこう','ひこう','かくとう','かくとう','かくとう','かくとう','かくとう']
  ]
  getMezapa = ->
    row = col = 0
    if pm.individualValue[4]%2 is 1
      if pm.individualValue[3]%2 is 1
        if pm.individualValue[5]%2 is 1
          row = 0
        else
          row = 1
      else
        if pm.individualValue[5]%2 is 1
          row = 2
        else
          row = 3
    else
      if pm.individualValue[3]%2 is 1
        if pm.individualValue[5]%2 is 1
          row = 4
        else
          row = 5
      else
        if pm.individualValue[5]%2 is 1
          row = 6
        else
          row = 7
    if pm.individualValue[2]%2 is 1
      if pm.individualValue[1]%2 is 1
        if pm.individualValue[0]%2 is 1
          col = 0
        else
          col = 1
      else
        if pm.individualValue[0]%2 is 1
          col = 2
        else
          col = 3
    else
      if pm.individualValue[1]%2 is 1
        if pm.individualValue[0]%2 is 1
          col = 4
        else
          col = 5
      else
        if pm.individualValue[0]%2 is 1
          col = 6
        else
          col = 7
    $scope.mezapa = mezapa[row][col]


  $scope.pokeModel = pm
  $scope.updateStat = updateStat
  $scope.updateStats = ->
    for i in [0...6]
      updateStat i

  $scope.updateIndividualValue = ->
    getMezapa()
    $scope.updateStats()

  $scope.updateBaseStats = ->
    index = pm.pokeData.pokeName.indexOf pm.name
    if index isnt -1
      pm.baseStats = pm.pokeData.pokeBaseStats[index]
      $scope.updateStats()

  $scope.getMatcheNames = (searchText)->
    searchText = romaji.toKatakana searchText
    re = new RegExp searchText
    return pm.pokeData.pokeName.filter (element,index,array)->
      if element.match re
        return true
      else
        return false

  $scope.getMatcheNatNames = (searchText)->
    searchText = romaji.toHiragana searchText
    re = new RegExp searchText
    return pm.pokeData.natName.filter (element,index,array)->
      if element.match re
        return true
      else
        return false

  $scope.updateEffortValue = (index)->
    tmp = 0
    for val in pm.effortValue
      tmp += val
    if 510-tmp < 0
      pm.effortValue[index] -= tmp-510
    updateStat(index)

  $scope.getNatCorrectionString = (index)->
    natCorr = pm.pokeData.natCorrection[index]
    str = '（'
    for value,index in natCorr
      if value is 1.1
        str += pm.statsName[index+1]+'↑'
      if value is 0.9
        str += pm.statsName[index+1]+'↓'
    str += '）'
    return str

  $scope.mezapa = getMezapa()
  $scope.result = ''
  makeResult = ->
    str = pm.name+'\n'+pm.nature+' Lv:'+pm.level+'\n'
    for value,index in pm.effortValue
      if value isnt 0
        str += pm.statsName[index]+':'+value+' '
    str += '\n'
    for val in pm.individualValue
      if val isnt 31
        str += '個体値['+pm.individualValue+']\n'
        break
    str += '能力値['+pm.stats+']'
    $scope.result = str

  clip = new ZeroClipboard(document.getElementById('clipBtn'))
  clip.on 'beforecopy',->
    makeResult()
  clip.on 'aftercopy',->
    $mdToast.show $mdToast.simple().content $scope.result
]
