# get a better library instead of this ugly hack?
self.window = self
System.import 'gifuct-js/dist/gifuct-js.min.js'
  .then ->
    self.onmessage = ({data:url}) ->
      onError = (error) -> self.postMessage type: 'error', url: url, error: "#{error?.message or error}\n#{error?.stack or ''}"
      request = new XMLHttpRequest
      request.open 'GET', url, true
      request.responseType = 'arraybuffer'
      request.onload = ->
        try
          if request.response?
            gif = new GIF request.response
            duration = 0
            for {dims: {top, left, width, height}, delay, patch}, index in gif.decompressFrames true
              image = new ImageData patch, width, height
              duration += delay
              self.postMessage {type: 'frame', y: top, x: left, width, height, delay, index, url, image}, [patch.buffer]
          self.postMessage {type: 'complete', url, duration}
        catch error
          onError error
      request.onerror = onError
      request.send null
    # self.postMessage type: 'ready'
