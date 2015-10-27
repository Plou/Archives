class Navigation
  constructor: (@id, @links, @EVENT = { get: 'click' }) ->
    @el = $('#'+@id)
    @links = $('.'+@links)

    @setGetEVENT()
    $(window).on 'popstate', (e) =>
      @getPost e.target.document.location.href, false

  getPost: (url, push) ->
    content = url
    jQuery.ajax {
      type : 'GET'
      url : url
      success : (data) =>
        @.displayPost data
        @.pushState url, data, push
        @el.trigger('change')
      error: (data) ->
        console.log '<p class="ajaxError">Error :'+data.status+' - '+data.statusText+'/>'
    }

  displayPost: (content) ->
    @el.html($(content).find('#'+@id).contents())

  pushState: (url, content, push) ->
    title = content.match(/<title>(.*?)<\/title>/)[0]
    $('title').replaceWith(title)
    $('meta[name="description"]').attr('content', "")

    #push to google analytics
    _gaq.push ['_trackPageview', url]

    if Modernizr.history && push
      history.pushState null, null, url

  setGetEVENT: (event = @EVENT.get) ->
    @links.unbind @EVENT.get
    @EVENT.get = event
    @bindGetEVENT()

  bindGetEVENT: ->
    @links.on @EVENT.get, (e) =>
      e.preventDefault()
      @links.closest(".post").removeClass "current"
      $(e.target).closest(".post").addClass "current"
      @.getPost $(e.target).closest(".links").attr('href'), true

root = exports ? window
root.Navigation = Navigation