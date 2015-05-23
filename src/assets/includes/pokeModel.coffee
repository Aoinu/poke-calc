require 'angular'

pc = require './pokeData'

pc.factory 'pokeModel',['pokeData',(pokeData)->
  return {
    name: ''
    level: 50
    baseStats: [0,0,0,0,0,0]
    effortValue: [0,0,0,0,0,0]
    individualValue: [31,31,31,31,31,31]
    nature: 'がんばりや'
    stats: [0,0,0,0,0,0]
    statsName: [
      'HP'
      '攻撃'
      '防御'
      '特攻'
      '特防'
      '素早さ'
    ]
    pokeData: pokeData
  }
]

module.exports = pc
