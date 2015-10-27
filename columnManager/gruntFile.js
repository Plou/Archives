module.exports = function(grunt) {

  // Load Grunt tasks declared in the package.json file
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);

  // Configure Grunt
  grunt.initConfig({

    // grunt-contrib-connect will serve the files of the project
    // on specified port and hostname
    connect: {
      all: {
        options:{
          port: 9000,
          hostname: "localhost",
          // No need for keepalive anymore as watch will keep Grunt running
          //keepalive: true,

          // Livereload needs connect to insert a cJavascript snippet
          // in the pages it serves. This requires using a custom connect middleware
          middleware: function(connect, options) {

            return [
              // Serve the project folder
              connect.static(options.base)
            ];
          }
        }
      }
    },
    // grunt-open will open your browser at the project's URL
    open: {
      all: {
        // Gets the port from the connect configuration
        path: 'http://localhost:<%= connect.all.options.port%>/examples/'
      },
    },

    coffee: {
      build: {
        options: {
          join: true,
          sourceMap: true
        },
        files: {
          './columnManager.js': 'src/*.coffee'
        }
      }
    },

    uglify: {
      build: {
        src: './columnManager.js',
        dest: './columnManager.min.js'
      }
    },

    watch: {
      all: {
        files:['./columnManager.js'],
        tasks: ['uglify:build']
      },
      coffee: {
        files: ['src/*.coffee'],
        tasks: ['coffee:build']
      }
    }
  });

  // Creates the `server` task
  grunt.registerTask('server',[
    'connect',
    // Connect is no longer blocking other tasks, so it makes more sense to open the browser after the server starts
    'open',
    // Starts monitoring the folders and keep Grunt alive
    'watch'
  ]);
  // Creates the `server` task
  grunt.registerTask('build',[
    'coffee:build',
    'uglify:build'
  ]);
};