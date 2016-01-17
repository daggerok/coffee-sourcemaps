gulp    = require 'gulp'
connect = require 'gulp-connect'
open    = require 'gulp-open'

module.exports = gulp.task 'connect', ->
  connect.server
    root: '.'
    livereload: true

module.exports = 
  gulp: gulp
  connect: connect
  open: open