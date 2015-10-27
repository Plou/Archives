# Helpers
#
# getHash = require './components/getHash.coffee'

# jQuery helpers
#
# require('./components/jquery.hoverSrc.coffee')
# require('./components/jquery.pulldown.coffee')
# require('./components/jquery.fixToTop.coffee')
# require('./components/jquery.smoothAnchors.coffee')

# components
Colorfull = require('./components/ColorFull.coffee')

# Website wide scripts
# @author Plou
#
$( ->
  $(window).ready( ->
    serverUrl = 'ws://82.233.189.9:8080'
    currentColor = 0
    colorfull = new Colorfull('ion-content')
    window.ws =  new WebSocket(serverUrl)
    ws.onopen = (e) ->
      ws.onmessage = (data, flags) ->
        color = if data.data then data.data else null
        colorfull.updateColor(color, .5)

    $('.update-color').on('click', ->
      if ws.readyState != 1
        disconnected()
        setTimeout(connect(), 1000)
      else
        color = $(this).attr('data-color')
        switch color
          when 'prev'
            currentColor = if currentColor == 0 then colors.length else currentColor - 1
            ws.send(colors[currentColor])
          when 'next'
            currentColor = if currentColor == colors.length then  0 else currentColor + 1
            ws.send(colors[currentColor])
          when 'random'
            ws.send('')
          else
            ws.send($(this).attr('data-color'))
    )
    # Handle src update on hover event
    # $('.no-touch img.hover').hoverSrc()

    ###
    # Handle pulldown
    $('.pulldown').pulldown()

    # Add backToTop anchor when half a screen  is scrolled
    $('body').append('<a id="backToTop" href="#">Back to top</a>')
    $('#backToTop').backToTop($(window).height()/2)

    # Refresh scroll offset of backToTop button appearance
    $(window).bind('resize', ->
      $('#backToTop').backToTop($(window).height()/2)
    )
    ###
  )
)

colors = ['AliceBlue', 'AntiqueWhite', 'Aqua', 'Aquamarine', 'Azure', 'Beige', 'Bisque', 'Black', 'BlanchedAlmond', 'Blue', 'BlueViolet', 'Brown', 'BurlyWood', 'CadetBlue', 'Chartreuse', 'Chocolate', 'Coral', 'CornflowerBlue', 'Cornsilk', 'Crimson', 'Cyan', 'DarkBlue', 'DarkCyan', 'DarkGoldenRod', 'DarkGray', 'DarkGreen', 'DarkKhaki', 'DarkMagenta', 'DarkOliveGreen', 'DarkOrange', 'DarkOrchid', 'DarkRed', 'DarkSalmon', 'DarkSeaGreen', 'DarkSlateBlue', 'DarkSlateGray', 'DarkTurquoise', 'DarkViolet', 'DeepPink', 'DeepSkyBlue', 'DimGray', 'DodgerBlue', 'FireBrick', 'FloralWhite', 'ForestGreen', 'Fuchsia', 'Gainsboro', 'GhostWhite', 'Gold', 'GoldenRod', 'Gray', 'Green', 'GreenYellow', 'HoneyDew', 'HotPink', 'IndianRed', 'Indigo', 'Ivory', 'Khaki', 'Lavender', 'LavenderBlush', 'LawnGreen', 'LemonChiffon', 'LightBlue', 'LightCoral', 'LightCyan', 'LightGoldenRodYellow', 'LightGray', 'LightGreen', 'LightPink', 'LightSalmon', 'LightSeaGreen', 'LightSkyBlue', 'LightSlateGray', 'LightSteelBlue', 'LightYellow', 'Lime', 'LimeGreen', 'Linen', 'Magenta', 'Maroon', 'MediumAquaMarine', 'MediumBlue', 'MediumOrchid', 'MediumPurple', 'MediumSeaGreen', 'MediumSlateBlue', 'MediumSpringGreen', 'MediumTurquoise', 'MediumVioletRed', 'MidnightBlue', 'MintCream', 'MistyRose', 'Moccasin', 'NavajoWhite', 'Navy', 'OldLace', 'Olive', 'OliveDrab', 'Orange', 'OrangeRed', 'Orchid', 'PaleGoldenRod', 'PaleGreen', 'PaleTurquoise', 'PaleVioletRed', 'PapayaWhip', 'PeachPuff', 'Peru', 'Pink', 'Plum', 'PowderBlue', 'Purple', 'RebeccaPurple', 'Red', 'RosyBrown', 'RoyalBlue', 'SaddleBrown', 'Salmon', 'SandyBrown', 'SeaGreen', 'SeaShell', 'Sienna', 'Silver', 'SkyBlue', 'SlateBlue', 'SlateGray', 'Snow', 'SpringGreen', 'SteelBlue', 'Tan', 'Teal', 'Thistle', 'Tomato', 'Turquoise', 'Violet', 'Wheat', 'White', 'WhiteSmoke', 'Yellow', 'YellowGreen']

disconnected = ->
  $('.bar-footer .title').html('Disconnected')
  $('.bar-footer')
    .addClass('bar-assertive')
    .removeClass('bar-balanced')
    .removeClass('bar-footer-hidden')

connect = ->
  $('.bar-footer .title').html('Connecting')
  $('.bar-footer')
    .removeClass('bar-assertive')
    .addClass('bar-balanced')

  if (typeof ws != 'undefined')
    ws.close()

  ws = new WebSocket(serverUrl)

  if colorfull?
    colorfull = new Colorfull('.scroll-content')

  ws.onopen = ->
    color = ''
    $('.bar-footer .title').html('Connected')
    $('.bar-footer').addClass('bar-footer-hidden')

    ws.onmessage = (data, flags) ->
      color = if data.data then  data.data else null
      colorfull.updateColor(color, .5)

  ws.onerror = ->
    setTimeout(connect(), 5000)
    disconnected()
