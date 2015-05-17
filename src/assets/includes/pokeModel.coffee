pc = angluar.module 'poke-calc',[]
pc.factory 'pokeModel',['pokeData',(pokeData)->
  return {
    name: ''
    level: 50
    baseStats: [0,0,0,0,0,0]
    effortValue: [0,0,0,0,0,0]
    individualValue: [0,0,0,0,0,0]
    nature: 'がんばりや'
    stats: [0,0,0,0,0,0]
    updateStat: (index)->
      tmp = Math.floor(
        BSvalue*2 + individualValue[index] + effortValue[index]/4
      )
      tmp = Math.floor(tmp * level/100)
      if index is 0
        statsArray[index] = tmp + 10 + level
      else
        natIndex = pokeData.natName.indexOf nature
        if natIndex isnt -1
          return Math.floor(
            (tmp+5)*pokeData.natCorrection[natIndex][index]
          )
        else
          return null
  }
]
