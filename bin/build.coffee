#global module:false
CSON = require 'cson-parser'
fs = require 'fs'
opener = require 'opener'

module.exports = (grunt) ->

  # Current tasks info
  isHelpModeActive = false
  for t in grunt.cli.tasks
    if t == "help"
      isHelpModeActive = true

  escapeRegExp = (str) -> str.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&")

  # Project configuration.
  mergeObj = (a, b) ->
    ret = {}
    for k, v of a
      ret[k] = v
    for k, v of b
      ret[k] = v
    return ret

  autoParseLabelsObj = (o) ->
    for k, v of o
      if typeof v == "string"
        for k2, v2 of o
          v = v.replace( new RegExp( escapeRegExp('$'+k2+''), 'g'), (key) ->
            v2.toString()
          )
        o[k] = v
    return o

  loadBuildConfig = () ->
    ret = null
    try
      ret = CSON.parse(grunt.file.read './src/BuildConfig.cson')
    catch error
      grunt.log.error "Invalid CSON build config.\nCheck your BuildConfig.cson file.\n#{error.message}"
    return ret

  config = grunt.file.readJSON "./package.json"
  buildTimeConfig = mergeObj(config, loadBuildConfig() )
  buildTimeConfig.STANDALONE = false
  buildTimeConfigStandalone = mergeObj({}, buildTimeConfig)
  buildTimeConfigStandalone.STANDALONE = true
  buildTimeConfigStandalone = autoParseLabelsObj buildTimeConfigStandalone
  buildTimeConfig = autoParseLabelsObj buildTimeConfig

  canWrite = (path, callback) ->
    fs.access path, fs.W_OK, (err) ->
      callback(!err)

  releaseHtmlMinGeneralConfig = {
    removeComments: true
    collapseWhitespace: true
    minifyCSS: true
    minifyJS: true
    minifyURLs: true
    removeEmptyAttributes: true
    sortAttributes: true
    sortClassName: true
    removeStyleLinkTypeAttributes: true
    removeScriptTypeAttributes: true
    removeRedundantAttributes: true
    removeOptionalTags: true
  }

  grunt.initConfig ((require './config')(grunt, config, buildTimeConfig, buildTimeConfigStandalone))

  grunt.registerTask 'display_help', 'Display usage help.', () ->
    helptext = grunt.file.read './bin/help.txt'
    grunt.log.write helptext

  grunt.registerTask 'open_build_index', 'Opens index file after build command', () ->
    opener "./build/index.html"

  grunt.registerTask 'open_release_index', 'Opens index file after release command', () ->
    grunt.log.write "./index.html?"
    opener "index.html"

  grunt.registerTask 'open_dev_index', 'Opens index file after dev command', () ->
    opener "localhost:3000"


  if !isHelpModeActive
    grunt.loadNpmTasks 'grunt-contrib-jade'
    grunt.loadNpmTasks 'grunt-contrib-stylus'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-browserify'
    grunt.loadNpmTasks 'grunt-contrib-htmlmin'
    grunt.loadNpmTasks 'grunt-contrib-cssmin'
    grunt.loadNpmTasks 'grunt-inline'
    grunt.loadNpmTasks 'grunt-file-info'
    grunt.loadNpmTasks 'grunt-contrib-connect'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-concat'
    grunt.loadNpmTasks 'grunt-contrib-uglify'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-contrib-clean'

  grunt.registerTask 'default', [
    'copy:build'
    'jade:build'
    'browserify:build'
    'stylus:build'
  ]
  grunt.registerTask 'build', [
    'default'
  ]

  grunt.registerTask 'show_build_stats_standalone', [
    'file_info:standalone'
  ]

  grunt.registerTask 'publish', [

  ]

  grunt.registerTask 'help', [
    'display_help'
  ]

  grunt.registerTask 'build_release_standalone', [
    'copy:build'
    'jade:build_standalone'
    'browserify:build_standalone'
    'stylus:build'
    'browserify:release_standalone'
    'copy:release'
    'stylus:release'
    'cssmin:release'
    'concat:release'
    'uglify:release_standalone'
    'inline:release_standalone'
    'htmlmin:release_standalone'
    'copy:release_finish'
    'show_build_stats_standalone'
  ]

  grunt.registerTask 'release', [
    'clean'
    'build_release_standalone'
    'clean'
  ]

  grunt.registerTask 'server', [
    'build'
    'connect'
    'watch'
  ]

  grunt.registerTask 'show', [
    'open_release_index'
  ]
