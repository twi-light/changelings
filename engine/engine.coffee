Engine = Matter.Engine
World = Matter.World
Bodies = Matter.Bodies

engine = Engine.create document.body
ground = Bodies.rectangle 400, 610, 810, 60, isStatic: true
bodies = []

SpriteObject = ->
  bunny = new PIXI.Sprite texture
  bunny.anchor.x = 0.5
  bunny.anchor.y = 0.5
  bunny.position.x = 200
  bunny.position.y = 150
  stage.addChild bunny
  bunny

PhysicsObject = ->
  x = Math.random() * 800 + 1
  y = Math.random() * 600 + 1
  scale = Math.random() * 20 + 20
  box = Bodies.rectangle x, y, scale, scale
  bodies.push box
  box

animate = ->
  requestAnimationFrame animate
  for b of bunnies
    bunnies[b].sprite.position = bunnies[b].body.position
    bunnies[b].sprite.rotation = bunnies[b].body.angle
  renderer.render stage
  return

bodies.push ground
renderer = PIXI.autoDetectRenderer 800, 600, backgroundColor: 0x1099bb
stage = new PIXI.Container
document.body.appendChild renderer.view
texture = PIXI.Texture.fromImage 'http://www.goodboydigital.com/pixijs/bunnymark/bunny.png'
bunnies = []

createBunny = ->
  {
    sprite: new SpriteObject
    body: new PhysicsObject
  }

for index in [0..150]
  bunnies.push createBunny()

animate()
World.add engine.world, bodies
Engine.run engine
