###
  gulp + gulp-coffee + browserify (js source maps)
###

{gulp, connect, open, sourcemaps} = require './common'
coffee     = require 'gulp-coffee'
browserify = require 'browserify'
source     = require 'vinyl-source-stream'
buffer     = require 'vinyl-buffer'

gulp.task 'coffee', ->
  gulp.src './app/scripts/**/*.coffee'
          , base: './app/scripts/'
    .pipe(do coffee)
    .pipe(gulp.dest './dist')

gulp.task 'browserify', ['coffee'], ->
  bundler = browserify 'dist/bundle.js'
  bundler.bundle()
    .pipe(source 'bundle.js')
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
  gulp.watch './app/scripts/**/*.coffee', ['browserify']
  gulp.src('./').pipe open uri: 'http://localhost:8080'
