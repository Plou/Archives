jQuery(window).ready(function(){
    var Clockwork =  new window.solarClock.Clock("clock");
    $(Clockwork.el).on('clock.ready', function(){
        var sunData = JSON.stringify(Clockwork.sunData).replace(/[{,}]/gim,'<br />');
        $(this).after('<p>'+sunData+'</p>');
    })

});