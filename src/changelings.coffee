import 'style/changelings'
import debounce from 'debounce'
import loadGif from 'util/gif'

window.onload = ->
  renderer = new PIXI.WebGLRenderer window.innerWidth, window.innerHeight
  renderer.view.className = 'viewport'
  document.body.appendChild renderer.view
  renderer.autoResize = true
  window.onresize = debounce ->
    renderer.resize window.innerWidth, window.innerHeight
  , 200

  stage = new PIXI.Container
  direction = 1
  momentum = 0
  sprite = null
  fetch './assets/index.json'
    .then (response) -> response.json()
    .then ({actors}) -> loadGif actors.queen.fly
    .then (_sprite) ->
      stage.addChild sprite = _sprite
      sprite.animationSpeed = 0.42
      sprite.pivot.x = sprite.width / 2
      sprite.position.x = window.innerWidth / 2
      sprite.position.y = 275
      console.log window.sprite = sprite
      sprite.play()
  backgroundTile = (url) ->
    texture = PIXI.Texture.fromImage url
    stage.addChild tile = new PIXI.extras.TilingSprite texture, window.innerWidth, 512
    tile.position.x = tile.position.y = tile.tilePosition.y = 0
    tile.tilePosition.x = -512
    tile
  sky = backgroundTile './assets/backgrounds/sky.svg'
  mountains = backgroundTile './assets/backgrounds/mountains.svg'
  hills = backgroundTile './assets/backgrounds/hills.svg'
  grass = backgroundTile './assets/backgrounds/grass.svg'
  scrollSpeed = 0.1
  gameLoop = ->
    momentum += (direction - momentum) * 0.025
    if Math.random() < 0.0075
      direction *= -1
    if sprite?
      sprite.animationSpeed = Math.abs momentum
      sprite.scale.x = if momentum > 0 then 1 else -1
    requestAnimationFrame gameLoop
    sky.tilePosition.x -= scrollSpeed * 1 * momentum
    mountains.tilePosition.x -= scrollSpeed * 10 * momentum
    hills.tilePosition.x -= scrollSpeed * 20 * momentum
    grass.tilePosition.x -= scrollSpeed * 50 * momentum
    renderer.render stage
  do gameLoop
