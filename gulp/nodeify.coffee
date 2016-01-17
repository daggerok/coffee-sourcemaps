###
  node + browserify + coffeeify (coffee source maps)
###

{gulp, connect, open} = require './common'
coffeeify             = require 'coffeeify'
browserify            = require 'browserify'
fs                    = require 'fs'

gulp.task 'nodeify', (done) ->
  bundle = browserify 
    extensions: ['.coffee']
    debug: true
  bundle.transform coffeeify,
    bare: false
    header: false
  bundle.add './app/scripts/bundle.coffee'
  bundle.bundle (error, result) ->
    throw error if error?
    fs.writeFile  './bundle.js', result

  do connect.reload
  do done

gulp.task 'connect', ->
  connect.server
    root: '.'
    livereload: true

gulp.task 'watchify', ['nodeify', 'connect'], ->
  gulp.watch './app/scripts/**/*.coffee', ['nodeify']
  gulp.src('./').pipe open uri: 'http://localhost:8080'