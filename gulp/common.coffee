gulp       = require 'gulp'
connect    = require 'gulp-connect'

module.exports = gulp.task 'connect', ->
  connect.server
    root: '.'
    livereload: true

module.exports = 
  gulp: gulp
  connect: connect
  open: require 'gulp-open'
  sourcemaps: require 'gulp-sourcemaps'
  path:
    bundle: 'bundle.js'
    src: './app/scripts/'
    any: './app/scripts/**/*.coffee'
    url: 'http://localhost:8080'