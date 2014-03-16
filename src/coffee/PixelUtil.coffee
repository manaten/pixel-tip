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
    request = getXmlHttpObject()
    request.open 'GET', url, true
    request.overrideMimeType 'text\/plain; charset=x-user-defined' if request.overrideMimeType
    request.onload = =>
      throw "Couldn't load image: #{url}" if request.status != 200
      byteData = textToByteArray request.responseText
      callback(new PixelImage url, byteData)
    request.send null

getXmlHttpObject = ->
  if XMLHttpRequest? then new XMLHttpRequest() else new ActiveXObject('MSXML2.XMLHTTP.6.0')

#
# convert text to byte array.
#
textToByteArray = (text)->
  byteArray = new Array text.length
  for i in [0..text.length-1]
    byteArray[i] = text.charCodeAt(i) & 0xff
  byteArray
