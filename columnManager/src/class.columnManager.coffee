# class columnManager
# id    : an unique id used to select the DOM element
# el      : the DOM element
# columns : an array of columns
# views   : an array of views
# view    : the current view id
columnManager = class columnManager
  constructor: (@id, @columns, @views, resizeEvent) ->
    @el = $('#'+@id).css {
      'position' : 'absolute'
      'top'    : '0'
      'right'    : '0'
      'bottom'    : '0'
      'left'    : '0'
    }
    # the current view, default is 0
    @view = @views[0];
    # the current gutter position, default is 0
    @gutter = 0
    #the resize envent is needed to dynamicaly refresh the manager
    @resizeEvent = if resizeEvent then resizeEvent+" viewChange" else "resize viewChange"

    #store viewport attibutes
    @viewport = new viewport
    @viewport.refreshVoid = (gutter) =>
      gutter = if gutter then gutter else @gutter
      @viewport.void = $(window).width() - gutter
    @viewport.refreshVoid()

    for column, index in @columns
      column.index = index

    @lastColumn = @columns[@columns.length - 1]
    #set last column to right
    @lastColumn.el.css { 'right' : 0 }

    #refresh the manager one time and then on each viewChange or resize event
    @.refresh()
    $(window).on @resizeEvent, =>
      @.refresh()


  setPosition: (column, gutter) ->
    gutter = if gutter then gutter else @gutter
    cWidth = @.getSize column.index

    if  cWidth is "hide"
      column.el.hide()

    else if !cWidth
      column.el.hide()
      if @columns[@lastColumn.index-1] then @lastColumn = @columns[@lastColumn.index-1] else @lastColumn = @columns[@lastColumn.index]
      @lastColumn.el.css {
        'right' : 0
        'width' : "auto"
      }
      return true

    #check if the last column fit in the viewport
    else if cWidth <= @viewport.void
      column.el.show()
      column.el.css {
        'left' : gutter
        'right': if column is @lastColumn then 0 else "auto"
        'width': if column is @lastColumn then @viewport.void else cWidth
      }
      @gutter = (cWidth) + gutter
      @viewport.refreshVoid(@gutter)
      return true

    else if @view.pointer + 1 < @view.sizing.length
      @view.pointer = @view.pointer + 1
      @.refresh(@view.pointer)
      return false

    else
      console.log "error no layout of the view :"+@view.id+" could fit in the viewport last layout tried : "+@view.sizing[@view.pointer]
      @el.trigger "error", ["error no layout of the view :"+@view.id+" could fit in the viewport last layout tried : "+@view.sizing[@view.pointer]]
      return false

  refresh : (pointer) ->
    @gutter = 0
    @view.pointer = if pointer then pointer else 0
    @viewport.refresh()
    @viewport.refreshVoid()
    @lastColumn = @columns[@columns.length - 1]

    for column, index in @columns
      break if !@.setPosition column, @gutter
    @el.trigger "updated"

  getSize: (index) ->
    @view.sizing[@view.pointer][index]

  # set the current view
  setView: (id) ->
    @view = @views[id]
    $(window).trigger "viewChange"

  # get a column
  getColumn: (id) ->
    @columns[id]

  # get a view
  getView: (id) ->
    @views[id]


# class viewport
# width  : viewport width
# height : viewoport height
viewport = class viewport
  constructor: (@width, @height, @void) ->
    @width = $(window).width()
    @height = $(window).height()

  refresh : ->
    @width = $(window).width()
    @height = $(window).height()


root = exports ? window
root.cManager.columnManager = columnManager
root.cManager.viewport = viewport