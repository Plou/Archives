window.cManager or= {}
# class view
# id      : the view id
# sizing  : an array describing the columns behavior (layout)
window.cManager.view = class view
  constructor: (@id, @sizing) ->
    # refer to the current layout of the view
    @pointer = 0;

root = exports ? window
root.cManager.view = view