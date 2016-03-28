module.exports = (gulp, plugins)->
  gulp.task 'constants', ->
    config = require('./../../config.json')[plugins.config.env || 'development']

    plugins.ngConstant(
      name: 'constants'
      constants: { ENV: config },
      stream: true
    ).pipe gulp.dest('www/js')
