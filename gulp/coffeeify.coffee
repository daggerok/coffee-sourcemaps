###
  gulp + coffeeify (coffee source maps)
###

{gulp, connect, open} = require './common'
gcoffeeify            = require 'gulp-coffeeify'
sourcemaps            = require 'gulp-sourcemaps'

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