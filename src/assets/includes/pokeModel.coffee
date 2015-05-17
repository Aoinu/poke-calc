require 'angular'

pc = require './pokeData'

pc.factory 'pokeModel',['pokeData',(pokeData)->
  return {
    name: ''
    level: 50
    baseStats: [0,0,0,0,0,0]
    effortValue: [0,0,0,0,0,0]
    individualValue: [0,0,0,0,0,0]
    nature: 'がんばりや'
    stats: [0,0,0,0,0,0]
    pokeData: pokeData
  }
]

module.exports = pc
