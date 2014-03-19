PixelImage = require './PixelImage.coffee'

module.exports =
  #
  # load image and get informations of image.
  # @param String url The url of image.
  # @param function callback
  #    The function called after load.
  #    It's first argument is object contains informations of image.
  #
  load: (url, callback)->
    request = new XMLHttpRequest()

    request.open 'GET', url, true
    request.responseType = "arraybuffer"
    request.onload = =>
      arrayBuffer = request.response
      throw "Couldn't load image: #{url}" if !arrayBuffer
      byteArray = new Uint8Array arrayBuffer
      callback(new PixelImage url, byteArray)

    request.send null
