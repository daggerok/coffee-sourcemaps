###
  gulp + gulp-coffeeify (coffee source maps)
###

{gulp, path, sourcemaps, connect, open} = require './common'
gcoffeeify = require 'gulp-coffeeify'

gulp.task 'coffeeify', ->
  gulp.src(path.any)
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
  gulp.watch path.any, ['coffeeify']
  gulp.src('./').pipe open uri: path.url