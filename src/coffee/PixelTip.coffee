PixelUtil = require './PixelUtil.coffee'

#
# A tip class
#
module.exports = class PixelTip
  constructor: (@url)->
    @bgcolor = 0
    @zoomLevel = 1
    @rotate = 0
    @flipX = false
    @flipY = false
    @visible = false

  show: (x, y)->
    @visible = true
    if !@$tip
      createTip.apply @, [x, y]
    else
      @$tip.css( "left": "#{x}px", "top": "#{y}px" ).show()

  hide: ->
    @visible = false
    @$tip.hide() if @$tip?

createTip = (x, y)->
  @$tip = $("<div class='pixelTip'></div>")
    .css(position: "absolute")
    .hide()
    .hover(null, ()=> @hide() )
    .appendTo(document.body)
  @$img = $("<img src='#{@url}'>")
    .css("background-color": bgcolors[0])

  PixelUtil.load @url, (imgInfo)=>
    $controll = $("<div class='controll'>#{imgInfo.name}</div>")
    $('<button class="zoomIn" type="button">+</button>')
      .click( ()=> zoomIn.apply @ ).appendTo($controll)
    $('<button class="zoomOut" type="button">-</button>')
      .click( ()=> zoomOut.apply @ ).appendTo($controll)
    $('<button class="bgColor" type="button">[ ]</button>')
      .click( ()=> changeBGColor.apply @ ).appendTo($controll)
    $('<button class="flipX" type="button">↔</button>')
      .click( ()=> flipX.apply @ ).appendTo($controll)
    $('<button class="flipY" type="button">↕</button>')
      .click( ()=> flipY.apply @ ).appendTo($controll)
    $('<button class="rotate" type="button">↻</button>')
      .click( ()=> rotate.apply @ ).appendTo($controll)

    @$tip.append($controll)
      .append($('<div class="container"></div>').append(@$img))
      .append($("<div class='info'>" +
        "<span class='width'>#{imgInfo.width}</span>" +
        "<span class='height'>#{imgInfo.height}</span>" +
        "<span class='size'>#{imgInfo.fileSize}</span>" +
        "<span class='colorNum'>#{imgInfo.colorNum}</span>" +
        "<span class='depth'>#{imgInfo.colorDepth}</span></div>"))
    appendPaletteTable.apply @, [@$tip, imgInfo.palette]

    @baseWidth  = @$img.attr("width")  || imgInfo.width
    @baseHeight = @$img.attr("height") || imgInfo.height
    setStyles.apply @
    @show x, y if @visible

appendPaletteTable = ($tip, palette)->
  if palette.length is 0
    return

  $colorDiv = $ '<div class="color">#000000</div>'
  $table = $ "<table class='palette'></table>"
  for y in [0..15]
    $tr = $ "<tr></tr>"
    for x in [0..15]
      offset = x + y * 16
      (=>
        if offset >= palette.length
          return
        color = "#" + palette[offset]
        $("<td></td>")
          .css("background-color": color)
          .mouseover(()=> $colorDiv.text(color).css( "border-color": color ) )
          .click(()=> changeBGColor.apply(@, [color]) )
          .appendTo($tr)
      )()

    $table.append $tr if $tr.children().size()
  $tip.append($table).append $colorDiv

bgcolors = ["#FFF", "#FCC", "#CFC", "#CCF", "#F33", "#3F3", "#33F", "#FF3", "#3FF", "#F3F", "#000"]
changeBGColor = (color)->
  if !color
    @bgcolor = (@bgcolor + 1) % bgcolors.length
    color = bgcolors[@bgcolor]
  else
    @bgcolor = -1
  @$img.css "background-color": color

zoomIn = ->
  @zoomLevel = @zoomLevel * 2 if @zoomLevel < 8
  fixSize.apply @

zoomOut = ->
  @zoomLevel = @zoomLevel / 2 if @zoomLevel > 1
  fixSize.apply @

fixSize = ->
  @$img
    .attr("width", "#{@baseWidth * @zoomLevel}px")
    .attr("height", "#{@baseHeight * @zoomLevel}px")
  setStyles.apply @

flipX = ->
  @flipX = !@flipX
  setStyles.apply @

flipY = ->
  @flipY = !@flipY
  setStyles.apply @

rotate = ->
  @rotate = (@rotate + 1) % 4
  setStyles.apply @

setStyles = ->
  offset = (@baseWidth - @baseHeight) * @zoomLevel / 2
  transform = ''
  @rotate isnt 0 && (transform += " rotate(#{@rotate * 90}deg)")
  @rotate is 1 && (transform += " translate(#{offset}px, 0px)")
  @rotate is 3 && (transform += " translate(#{-offset}px, 0px)")

  @flipX && (transform += ' rotateY(180deg)')
  @flipY && (transform += ' rotateX(180deg)')
  @$img.css('transform': transform)

  width  = if @rotate % 2 == 1 then Math.max @baseHeight, @baseWidth else @baseWidth
  height = @[if @rotate % 2 == 1 then "baseWidth" else "baseHeight"]
  @$img.parent().css
    "width":  "#{width  * @zoomLevel}px",
    "height": "#{height * @zoomLevel}px"
