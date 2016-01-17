###
  gulp + gulp-coffee + browserify (js source maps)
###

{gulp, path, sourcemaps, connect, open} = require './common'
coffee     = require 'gulp-coffee'
browserify = require 'browserify'
source     = require 'vinyl-source-stream'
buffer     = require 'vinyl-buffer'

gulp.task 'coffee', ->
  gulp.src path.any
          , base: path.src
    .pipe(do coffee)
    .pipe(gulp.dest './dist')

gulp.task 'browserify', ['coffee'], ->
  bundler = browserify "dist/#{path.bundle}"
  bundler.bundle()
    .pipe(source path.bundle)
    .pipe(do buffer)
    .pipe(do sourcemaps.init)
    .pipe(do sourcemaps.write)
    .pipe(gulp.dest './')
    .pipe(do connect.reload)

gulp.task 'connect', ->
  connect.server
    root: '.'
    livereload: true

gulp.task 'browatch', ['browserify', 'connect'], ->
  gulp.watch path.any, ['browserify']
  gulp.src('./').pipe open uri: path.url