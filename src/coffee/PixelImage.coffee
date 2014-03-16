#
# The class handle image pixels
#
module.exports = class PixelImage
  constructor: (@url, @byteData)->
    @name = @url.split('/').pop()
    @palette = null
    @colorDepth = 0

    # Set propaties from private methods.
    @isGif    = isGif.apply @
    @isPng    = isPng.apply @
    @fileSize = getFileSize.apply @
    @width    = getWidth.apply @
    @height   = getHeight.apply @
    @palette  = getPalette.apply @
    @colorNum = unique(@palette).length


unique = (array)->
  _a = array.slice(0).sort()
  result = []
  for i, value of _a
    result.push value if !_a[i-1]? || _a[i-1] isnt value
  result

#
# Return the byte size of image.
#
getFileSize = ->
  @byteData.length

#
# Return true when image is png otherwise false.
#
isPng = ->
  src = @byteData
  return src.length > 24 &&
    src[0] is 0x89 && src[1] is 0x50 && src[2] is 0x4E && src[3] is 0x47 &&
    src[4] is 0x0D && src[5] is 0x0A && src[6] is 0x1A && src[7] is 0x0A

#
# Return true when image is git otherwise false.
#
isGif = ->
  src = @byteData
  return src.length > 22 && src[0] is 0x47 && src[1] is 0x49 && src[2] is 0x46

#
# Get the width of image.
#
getWidth = ->
  src = @byteData
  width = 0
  if isPng.apply @
    width += src[16] << 24
    width += src[17] << 16
    width += src[18] << 8
    width += src[19]
  else if isGif.apply @
    width += src[7] << 8
    width += src[6]
  width

#
# Get the height of image.
#
getHeight = ->
  src = @byteData
  height = 0
  if isPng.apply @
    height += src[20] << 24
    height += src[21] << 16
    height += src[22] << 8
    height += src[23]
  else if isGif.apply @
    height += src[9] << 8
    height += src[8]
  height

toHexString = (num)->
  (if num < 0x10 then '0' else '') + num.toString 16

getPaletteFromSource = (src, colorDepth, offset)->
  size = Math.pow 2, colorDepth
  if offset + size * 3 > src.length
    return []
  palette = new Array size
  for i in[0..size-1]
    red   = src[i*3+offset]
    green = src[i*3+offset+1]
    blue  = src[i*3+offset+2]
    palette[i] = toHexString(red) + toHexString(green) + toHexString(blue)
  palette

getPngPalette = ->
  src = @byteData
  colorDepth = src[24]
  offset = 8
  if src[25] is 3
    # seek a chank of 'PLTE'
    while offset < src.length
      if ((src[offset+4] is 0x50) && # P
       (src[offset+5] is 0x4C) && # L
       (src[offset+6] is 0x54) && # T
       (src[offset+7] is 0x45)) # E
        offset += 8
        break
      offset += 12 + (src[offset]<<24) + (src[offset+1]<<16) + (src[offset+2]<<8) + (src[offset+3])
  else
    return []
  @colorDepth = colorDepth
  getPaletteFromSource src, colorDepth, offset

getGifPalette = ->
  src = @byteData
  colorDepth = 0
  offset = 13
  gctf = (src[10]>>7) & 0x1
  if gctf is 1
    colorDepth = (src[10] & 0x7) + 1
  else
    # if gif file not has gct, seeking first lct and get offset to there.
    while offset < src.length
      if src[offset] is 0x2c
        colorDepth = (src[offset + 9] & 0x7) + 1
        offset += 10
        break
      else if src[offset] is 0x21
        if src[offset + 1] is 0xf9
          # Graphic Control Extension
          offset += 8
        else if src[offset + 1] is 0xfe
          # Comment Extension
          offset += 2
          while src[offset] isnt 0
            offset += src[offset] + 1
          offset += 1
        else if src[offset + 1] is 0x01
          # Plain Text Extension
          offset += 15
          while src[offset] != 0
            offset += src[offset] + 1
          offset += 1
        else if src[offset + 1] is 0xff
          # Application Extension
          offset += 14
          while src[offset] != 0
            offset += src[offset] + 1
          offset += 1
        else
          return []
      else
        return []
  @colorDepth = colorDepth
  getPaletteFromSource src, colorDepth, offset

#
# Get the palette array of image.
#
getPalette = ->
  # momerize
  if @palette isnt null
    return @palette
  if isPng.apply @
    return getPngPalette.apply @
  if isGif.apply @
    return getGifPalette.apply @
  throw "File is not PNG or GIF.: #{@url}"
