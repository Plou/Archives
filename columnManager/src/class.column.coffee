window.cManager or= {}
# class column
# id      : an unique id used to select the DOM element
# el      : the DOM element
# min     : the min-width
# max     : the max-width
# medium  : the medium-width or auto
window.cManager.column = class column
  constructor: (@id, @min, @max, @medium) ->
    @el = $('#'+@id).css {
      'position' : 'absolute'
      'display' : 'block'
    }

root = exports ? window
root.cManager.column = column