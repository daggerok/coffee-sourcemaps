###
  node + browserify + coffeeify (coffee source maps)
###

{gulp, path, connect, open} = require './common'
browserify = require 'browserify'
coffeeify  = require 'coffeeify'
fs         = require 'fs'

gulp.task 'nodeify', (done) ->
  bundle = browserify 
    extensions: ['.coffee']
    debug: true
  bundle.transform coffeeify,
    bare: false
    header: false
  bundle.add "#{path.src}bundle.coffee"
  bundle.bundle (error, result) ->
    throw error if error?
    fs.writeFile  "./#{path.bundle}", result

  do connect.reload
  do done

gulp.task 'connect', ->
  connect.server
    root: '.'
    livereload: true

gulp.task 'watchify', ['nodeify', 'connect'], ->
  gulp.watch path.any, ['nodeify']
  gulp.src('./').pipe open uri: path.url