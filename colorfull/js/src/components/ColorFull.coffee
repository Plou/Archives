# Update colors
# @param
#
# @return [Colorfull]
class Colorfull
  constructor: (selector) ->
    @body = $(selector).get(0)
    @colors = require('./colors.coffee')
    return @

  getRandomColor: ->
    return [Math.floor(Math.random() * @colors.length)]

  updateColor: (color, duration, easing) ->
    easing ?= 'ease-in-out'
    duration ?= 1
    transition = 'background ' + duration + 's ' + easing
    @body.style.transition = transition

    color ?= @colors[@getRandomColor()]
    @body.style.backgroundColor = color
    return @

module?.exports = Colorfull
