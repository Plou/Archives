$ ->
  $(window).ready ->
    # ## Emulate navigation capacities(&lt;a href="url"&gt;) on any tag
    # Use *[data-url]* value attribute (an url) to get the user to this target url
    $("[data-url]")
      .on "click", (e) ->
        e.preventDefault()
        document.location.href = $(this).attr("data-url")
      .on "keyUp", (e) ->
        if e.keyCode is 13 then document.location.href = $(this).attr("data-url")


    # ## Include an element from a html retrieved via ajax call
    # Use *[data-include]* & *[data-element]* value attributes to get the html and exctract the element from it.
    $("[data-include]").each (e) ->
      $that = $(this)
      $.get $(this).attr("data-include"), null, (data) ->
        $content = $(data).filter($that.attr("data-element"))
        $that.html $content



    $(window).on "keyup", (e) ->
      switch e.keyCode
        when [83, 70]
          setView "nav"
          $('#search').trigger "focus"
        when  27
          setView "post"
          $('a:focus').trigger "blur"

    # ## Filter posts list
    # Filter elements sharing a common class.
    # Activated at click on navigation items?
    # Use **.selected** class do to so.
    $("nav .all").addClass "selected"

    # Preview on mouse enter.
    $("nav:not(.navView nav)")
      .on "mouseenter", ->
        setView "nav"

    $("nav a")
      .on "click", (e) ->
        e.preventDefault()
        setView "list"
        if $(this).prop("selected") and not $(this).hasClass("all")
          $(this).prop("selected", false).removeClass "selected"
          $('.all').prop("selected", true).addClass "selected"
        else
          $(this).siblings("a").prop("selected", false).removeClass "selected"
          $(this).prop("selected", true).addClass "selected"
      .on "mouseenter focus", ->
        filter = "." + $(this).attr("data-filter")
        $(".posts article").not(filter).addClass "hide"
        $(".posts article" + filter).removeClass "hide"
      .on "focus", ->
        setView "nav"

    # set the view to post
    $("#post:not(.postView #post)")
      .on "mouseenter", ->
        if !$("#search").is(':focus')
          setView "post"

    $("#post")
      .on "change", ->
        setView "post"


    # hide the search input
    setTimeout ( ->
      $('#list').scrollTop(parseFloat($('#search').outerHeight()))
      ), 50

    # ## Change View on search
    $('#search')
      .on "focus", ->
        setView "nav"
      .on "blur", ->
        setView "post"
        $('#list').scrollTop(parseFloat($('#search').outerHeight()))
      .finder class: 'posts .post'

    $('.posts .post')
      .on 'click', (e) ->
        e.preventDefault()
        $(this).children('a').trigger('focus')

    $("#list:not(.postView #list)")
      .on "mouseenter", ->
        setView "list"

    $("#list a")
      .on "focus", ->
        setView "list"
      .on "keyup", (e) ->
        switch e.keyCode
          when 38 # up
            $(this).closest('article').prev().children('a').trigger "focus"
          when 39 # right
            $(this).closest('article').addClass('active')
            $(this).parent().siblings('article').removeClass('active')
          when 40 # down
            $(this).closest('article').next().children('a').trigger "focus"
          when 37 # left
            $(this).closest('article').removeClass('active')


    $(window).on "keyup", (e) ->
      switch e.keyCode
        when [83, 70]
          setView "nav"
          $('#search').trigger "focus"
        when  27
          setView "post"
          $('a:focus').trigger "blur"

    $(".no-touch nav a:last").on "blur", ->
      $(".no-touch nav").trigger('blur')

    # reinitialize previewed filters when leaving navigation area.
    $(".no-touch nav").on "mouseleave blur", ->
      $current = $(this).children(".selected")
      if $current.hasClass('all')
        $(".posts article").removeClass "hide"
      else $current.trigger('mouseenter')


    # ## Use HammerJs to handle gestures
    # *Work in progress*
    Hammer(".touch section").on "swipeleft", (e) ->
      e.gesture.preventDefault()
      setView "list"

    Hammer(".touch section").on "swiperight", (e) ->
      e.gesture.preventDefault()
      setView "nav"

    Hammer(".touch #list").on "swiperight", (e) ->
      e.gesture.preventDefault()
      setView "post"

    Hammer(".touch nav").on "swipeleft", (e) ->
      e.gesture.preventDefault()
      setView "post"

    Hammer(".touch list").on "swipeleft", (e) ->
      e.gesture.preventDefault()
      setView "post"

    setView = (view) ->
      switch view
        when "nav"
          if !$("body > .page").hasClass "navView"
            cM.setView(0)
            $("body > .page").addClass "navView"
            $("body > .page").removeClass "postView"
            $("body > .page").removeClass "listView"
        when "post"
          if !$("body > .page").hasClass "postView"
            cM.setView(1)
            $("body > .page").addClass "postView"
            $("body > .page").removeClass "navView"
            $("body > .page").removeClass "listView"
        when "list"
          if !$("body > .page").hasClass "listView"
            cM.setView(2)
            $("body > .page").addClass "listView"
            $("body > .page").removeClass "navView"
            $("body > .page").removeClass "postView"

    navigation = new Navigation "post", "links", { get: 'click focus' }


    cNav = new cManager.column "nav", 20, 250, 64
    cPost = new cManager.column "post", 320, 696, 512
    cList = new cManager.column "list", 168, 256

    vPost = new cManager.view "post",
      [
        [cNav.max, cList.max, cPost.max]
        [cNav.medium, cList.max, cPost.max]
        [cNav.medium, cList.max, cPost.medium]
        [cNav.medium, cList.min, cPost.medium]
        [cNav.medium, "hide", cPost.max]
        [cNav.min, "hide", cPost.min]
        [cNav.min, "hide", 10]
      ]
    vNav = new cManager.view "nav",
      [
        [cNav.max, cList.max, cPost.max]
        [cNav.max, cList.max, cPost.medium]
        [cNav.max, cList.max, cPost.min]
        [cNav.max, cList.min, cPost.min]
        [cNav.max, cList.max]
        [cNav.max, cList.min]
        [cNav.max, "hide"]
      ]
    vList = new cManager.view "list",
      [
        [cNav.max, cList.max, cPost.max]
        [cNav.max, cList.max, cPost.medium]
        [cNav.max, cList.max, cPost.min]
        [cNav.max, cList.min, cPost.min]
        [cNav.max, cList.max]
        [cNav.medium, cList.max]
        [cNav.medium, cList.min]
        [cNav.min, cList.max]
        [cNav.min, cList.min]
      ]

    window.cM = new cManager.columnManager "cManager",
      [
        cNav
        cList
        cPost
      ],
      [
        vNav
        vPost
        vList
      ]

    cM.el.one "updated", ->
      $(this).css('opacity', 1)

    $(window).on "viewChange", ->
      # addClass to the navigation column to manage the text display
      switch cM.view.id
        when "post"
          if cM.view.pointer is 0 then cNav.el.addClass('max') else cNav.el.removeClass('max')
        when "list"
          if cM.view.pointer in [0, 1, 2, 3, 4] then cNav.el.addClass('max') else cNav.el.removeClass('max')
        when "nav"
          cNav.el.addClass('max')

    #init the view on the post view
    cM.setView(1)

