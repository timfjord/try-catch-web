module.exports = (gulp, plugins)->
  gulp.task 'annotate', ->
    if plugins.config.env isnt 'development'
      gulp.src ["www/min/bundle.min.js"]
      .pipe plugins.ngAnnotate()
      .pipe gulp.dest "www/min"
