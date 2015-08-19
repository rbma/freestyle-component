'use strict'

angular
  
  .module('rbmaFreestyleComponent', [])

  .factory 'DollService', ->
    

    Doll = (item, image) ->

      self = this

      self.xPos = Math.floor(Math.random() * window.innerWidth) / 3
      self.yPos = (window.innerHeight - 300)
      self.direction = Math.round(Math.random())
      self.path = item.image
      self.bio = item.bio
      self.audio = item.audio
      self.name = item.name
      self.width = window.innerWidth
      self.height = window.innerHeight
      self.x = 0
      self.y = 0
      self.width = 0
      self.height = 400
      self.img = image
      self.sprite = new PIXI.Sprite.fromImage(item.image)
      self.speed = Math.random()
      self.upCount = 0
      self.goingUp = false
      self.maxUp = Math.floor((Math.random() * 15) + 5)

      self.init()


      Doll.prototype = 
        init: ->
          self = this
          self.loadImage()


        loadImage: ->
          self = this

          self = this
 
            
          if self.direction == 0

              self.x = -self.xPos
              self.y = self.yPos
              #Keep aspect
              self.width = (self.img.width * 400) / self.img.height
              self.goingUp = true
                  


          else

              self.width = (self.img.width * 400) / self.img.height
              self.x = self.xPos + self.width
              self.y = self.yPos
              self.goingUp = false



          #------------------------
          # Add to PIXI
          #------------------------
          self.sprite.interactive = true
          self.sprite.buttonMode = true
          self.sprite.width = self.width
          self.sprite.height = self.height
          self.sprite.position.set(self.x, self.y)
          

          self.sprite.on 'mousedown', (event) ->
              event.stopPropagation()
              Info.on(self)

              # console.log self

          

          Stage.addChild(self.sprite)
          return




    return Doll(item, image)

  
  #----------------------------------------------
  #STAGE SERVICE
  #----------------------------------------------
  .factory 'StageService', ->

    Stage =

      renderer: {},
      stage: {},

      init: ->
          self = this
          parent = document.getElementById 'header'
          winWidth = window.innerWidth
          winHeight = window.innerHeight

          #PIXI Setup
          self.renderer = PIXI.autoDetectRenderer(winWidth, winHeight, {transparent: true})
          parent.appendChild self.renderer.view
          self.stage = new PIXI.Container()

          #pass stage to animate
          Animate.setStage(self.stage)
          Animate.setRenderer(self.renderer)

          #Set up graphics click area
          clickBox = ClickArea()
          self.stage.addChild(clickBox)

          return self.stage

      addChild: (child) ->
          self = this
          self.stage.addChild(child)

    return Stage


  #INFO
  .factory 'InfoService', ->

    info = document.getElementById 'info'
    audio = document.getElementById 'audio'
    audiomp3 = document.getElementById 'mp3'

    Info =
    
      on: (item) ->
          name = item.name
          bio = item.bio
          template = "<h2>#{name}</h2><p>#{bio}</p>"
          info.classList.add 'active'
          info.innerHTML = template
          mp3.setAttribute 'src', ''
          mp3.setAttribute 'src', item.audio
          audio.load()
          audio.play()

      off: ->
          info.classList.remove 'active'
          info.innerHTML = ''
          audio.pause()


    return Info




  
  .controller 'FreestyleComponentController', ($scope, Couchdb, InfoService, StageService, DollService) ->
    Couchdb.getSearchView 'search', 'multiSearch', q: 'type:freestyleComponent', include_docs: true, true
      .then (resp) ->
        console.log 'yo', resp.data

        $scope.testing = 'Testing'
