// Ionic Starter App

// angular.module is a global place for creating, registering and retrieving Angular modules
// 'starter' is the name of this angular module example (also set in a <body> attribute in index.html)
// the 2nd parameter is an array of 'requires'
angular.module('starter', ['ionic'])

.run(function($ionicPlatform) {
  $ionicPlatform.ready(function() {
    var currentColor = 0;
    // Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
    // for form inputs)
    if(window.cordova && window.cordova.plugins.Keyboard) {
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
    }
    if(window.StatusBar) {
      StatusBar.styleDefault();
    }

    serverUrl = 'ws://82.233.189.9:8080';
    connect('ws://82.233.189.9:8080');

    angular.element('.update-color').each( function() {

      ionic.onGesture('touch',
        function() {
          if (ws.readyState != 1) {
            disconnected();
            setTimeout(connect(), 1000);
          }
          else {
            color = this.getAttribute('data-color');
            switch (color) {
              case 'prev':
                currentColor =  currentColor == 0 ? colors.length : currentColor - 1
                ws.send(colors[currentColor])
                break;

              case 'next':
                currentColor = currentColor == colors.length ?  0 : currentColor + 1
                ws.send(colors[currentColor])
                break;

              case 'random':
                ws.send('')
                break;

              default:
                ws.send($(this).attr('data-color'))
                break;

            }
          }
        },
        this
      );
    });

  });
})

var colors = ['AliceBlue', 'AntiqueWhite', 'Aqua', 'Aquamarine', 'Azure', 'Beige', 'Bisque', 'Black', 'BlanchedAlmond', 'Blue', 'BlueViolet', 'Brown', 'BurlyWood', 'CadetBlue', 'Chartreuse', 'Chocolate', 'Coral', 'CornflowerBlue', 'Cornsilk', 'Crimson', 'Cyan', 'DarkBlue', 'DarkCyan', 'DarkGoldenRod', 'DarkGray', 'DarkGreen', 'DarkKhaki', 'DarkMagenta', 'DarkOliveGreen', 'DarkOrange', 'DarkOrchid', 'DarkRed', 'DarkSalmon', 'DarkSeaGreen', 'DarkSlateBlue', 'DarkSlateGray', 'DarkTurquoise', 'DarkViolet', 'DeepPink', 'DeepSkyBlue', 'DimGray', 'DodgerBlue', 'FireBrick', 'FloralWhite', 'ForestGreen', 'Fuchsia', 'Gainsboro', 'GhostWhite', 'Gold', 'GoldenRod', 'Gray', 'Green', 'GreenYellow', 'HoneyDew', 'HotPink', 'IndianRed', 'Indigo', 'Ivory', 'Khaki', 'Lavender', 'LavenderBlush', 'LawnGreen', 'LemonChiffon', 'LightBlue', 'LightCoral', 'LightCyan', 'LightGoldenRodYellow', 'LightGray', 'LightGreen', 'LightPink', 'LightSalmon', 'LightSeaGreen', 'LightSkyBlue', 'LightSlateGray', 'LightSteelBlue', 'LightYellow', 'Lime', 'LimeGreen', 'Linen', 'Magenta', 'Maroon', 'MediumAquaMarine', 'MediumBlue', 'MediumOrchid', 'MediumPurple', 'MediumSeaGreen', 'MediumSlateBlue', 'MediumSpringGreen', 'MediumTurquoise', 'MediumVioletRed', 'MidnightBlue', 'MintCream', 'MistyRose', 'Moccasin', 'NavajoWhite', 'Navy', 'OldLace', 'Olive', 'OliveDrab', 'Orange', 'OrangeRed', 'Orchid', 'PaleGoldenRod', 'PaleGreen', 'PaleTurquoise', 'PaleVioletRed', 'PapayaWhip', 'PeachPuff', 'Peru', 'Pink', 'Plum', 'PowderBlue', 'Purple', 'RebeccaPurple', 'Red', 'RosyBrown', 'RoyalBlue', 'SaddleBrown', 'Salmon', 'SandyBrown', 'SeaGreen', 'SeaShell', 'Sienna', 'Silver', 'SkyBlue', 'SlateBlue', 'SlateGray', 'Snow', 'SpringGreen', 'SteelBlue', 'Tan', 'Teal', 'Thistle', 'Tomato', 'Turquoise', 'Violet', 'Wheat', 'White', 'WhiteSmoke', 'Yellow', 'YellowGreen'];


var disconnected = function () {
  angular.element('.bar-footer .title').html('Disconnected');
  angular.element('.bar-footer')
    .addClass('bar-assertive')
    .removeClass('bar-balanced')
    .removeClass('bar-footer-hidden');
}

var connect = function () {
  angular.element('.bar-footer .title').html('Connecting');
  angular.element('.bar-footer')
    .removeClass('bar-assertive')
    .addClass('bar-balanced');
  if (typeof ws != "undefined") {
    ws.close();
  }
  ws = new WebSocket(serverUrl);

  if (typeof colorfull == "undefined") {
    colorfull = new Colorfull('.scroll-content');
  }

  ws.onopen = function(e) {
    var color;
    angular.element('.bar-footer .title').html('Connected');
    angular.element('.bar-footer').addClass('bar-footer-hidden');

    ws.onmessage = function(data, flags) {
      color = data.data ? data.data : null;
      colorfull.updateColor(color, .5);
    };
  };
  ws.onerror = function(e) {
    setTimeout(connect(), 5000);
    disconnected();
  };

}
