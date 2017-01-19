import GifWorker from 'worker/gif'

worker = undefined
export default loadGif = (url) -> new Promise (resolve, reject) ->
  worker ?= new GifWorker
  frames = []
  worker.addEventListener 'message', ({data}) ->
    # if data.type is 'ready' then worker.postMessage url
    if data.url is url
      switch data.type
        when 'frame'
          frames.push data
        when 'error'
          data.frames = frames
          reject data
        when 'complete'
          {duration} = data
          resolve new PIXI.extras.AnimatedSprite textures =
            for {x, y, height, width, delay, image}, index in frames
              canvas = document.createElement 'canvas'
              canvas._pixiId = "#{url},#{index}"
              canvas.height = height + y
              canvas.width = width + x
              context = canvas.getContext '2d'
              context.putImageData image, x, y
              document.body.appendChild canvas
              texture = PIXI.Texture.fromCanvas canvas
          , yes
  worker.postMessage url
