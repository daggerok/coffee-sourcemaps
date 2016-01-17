###
  gulp + coffeeify (coffee source maps)
###

gulp       = require 'gulp'
gcoffeeify = require 'gulp-coffeeify'
sourcemaps = require 'gulp-sourcemaps'
connect    = require 'gulp-connect'
open       = require 'gulp-open'

gulp.task 'coffeeify', ->
  gulp.src('./app/scripts/**/*.coffee')
    .pipe gcoffeeify
      options:
        debug: true
        paths: [
          "#{__dirname}/app/scripts"
        ]
    .pipe(sourcemaps.init loadMaps: true)
    .pipe(do sourcemaps.write)
    .pipe(gulp.dest './')
    .pipe(do connect.reload)

gulp.task 'default', ['coffeeify']

gulp.task 'connect', ->
  connect.server
    root: '.'
    livereload: true

gulp.task 'watch', ['default', 'connect'], ->
  gulp.watch './app/scripts/**/*.coffee', ['coffeeify']
  gulp.src('./').pipe open uri: 'http://localhost:8080'

###
  node + browserify + coffeeify (coffee source maps)
###

gulp       = require 'gulp'
coffeeify  = require 'coffeeify'
browserify = require 'browserify'
fs         = require 'fs'
connect    = require 'gulp-connect'
open       = require 'gulp-open'

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

gulp.task 'watchify', ['nodeify', 'connect'], ->
  gulp.watch './app/scripts/**/*.coffee', ['nodeify']
  gulp.src('./').pipe open uri: 'http://localhost:8080'

###
  gulp + gulp-coffee + browserify (js source maps)
###

gulp       = require 'gulp'
coffee     = require 'gulp-coffee'
browserify = require 'browserify'
source     = require 'vinyl-source-stream'
buffer     = require 'vinyl-buffer'
connect    = require 'gulp-connect'
open       = require 'gulp-open'

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

gulp.task 'browatch', ['browserify', 'connect'], ->
  gulp.watch './app/scripts/**/*.coffee', ['browserify']
  gulp.src('./').pipe open uri: 'http://localhost:8080'