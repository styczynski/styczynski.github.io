datetime = require('node-datetime')

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

module.exports = (grunt, config, buildTimeConfig, buildTimeConfigStandalone) ->
  {
    meta:
      version: '0.1.0',
      banner: ""

    clean:
      build: ['build']
      release: ['release']
      release_standalone: ['release_standalone']

    copy:
      build:
        files: [
          {
            cwd: './src/vendor/'
            src: '**/*'
            dest: './build/'
            expand: true
          }
          {
            cwd: './assets/'
            src: '**/*'
            dest: './build/assets/'
            expand: true
          }
        ]
      release:
        files: [
          {
            cwd: './build/'
            src: '**/*'
            dest: './release/'
            expand: true
          }
        ]
      release_finish:
        files: [
          {
            cwd: './release-standalone/'
            src: 'index.html'
            dest: '.'
            expand: true
          }
        ]
    jade:
      build:
        options:
          pretty: true
          data: buildTimeConfig
        files: grunt.file.expandMapping(["src/jade/index.jade"], "build",
          rename: (destBase, destPath) ->
            destBase + destPath.replace(/src\/jade/, '').replace(/\.jade$/, ".html")
        )
      build_standalone:
        options:
          pretty: true
          data: buildTimeConfigStandalone
        files: grunt.file.expandMapping(["src/jade/index.jade"], "build",
          rename: (destBase, destPath) ->
            destBase + destPath.replace(/src\/jade/, '').replace(/\.jade$/, ".html")
        )

    coffee:
      build:
        files: grunt.file.expandMapping(["src/coffee/**/*.coffee"], "build/js/",
          rename: (destBase, destPath) ->
            destBase + destPath.replace(/src\/coffee/, '').replace(/\.coffee$/, ".js")
        )

    browserify:
      release_standalone:
        files:
          'build/js/index.js': ['src/coffee/index.coffee']
        options:
          transform: [
            ['browserify-coffeelint', {
              doEmitErrors: true
            }]
            'caching-coffeeify'
            ['conditionalify', {
                context: buildTimeConfigStandalone
                marker: '#'
                exts: [ 'coffee' ]
            }]
            'require-globify'
            'csonify'
            ['uglifyify', {
              global: false
              ignore: [
                '**/vendor/js/dat.gui.min.js'
                '**/vendor/js/jquery.js'
              ]
              ###mangle: {
                except: ['exports', 'module', 'require', 'dat', '$']
                toplevel: true
                eval: true
                keep_fnames: false
              }
              mangleProperties: {
                ignore_quoted: true
              }
              reserveDOMProperties: true
              ###
              mangle: false
              mangleProperties: false
              reserveDOMProperties: false
              preserveComments: false
              compress: {
                sequences: 1000
                properties: true
                dead_code: true
                drop_debugger: true
                unsafe: true
                unsafe_comps: true
                conditionals: true
                comparisons: true
                evaluate: true
                booleans: true
                loops: true
                unused: true
                hoist_funs: true
                if_return: true
                join_vars: true
                cascade: true
                collapse_vars: true
                warnings: true
                negate_iife: true
                pure_getters: true
                drop_console: true
                keep_fargs: false
                keep_fnames: false
                passes: 1
              }
            }]
          ]
      build_standalone:
        files:
          'build/js/index.js': ['src/coffee/index.coffee']
        options:
          transform: [
            ['browserify-coffeelint', {
              doEmitErrors: true
            }]
            'caching-coffeeify'
            ['conditionalify', {
                context: buildTimeConfigStandalone
                marker: '#'
                exts: [ 'coffee' ]
            }]
            'require-globify'
            'csonify'
          ]
      release:
        files:
          'build/js/index.js': ['src/coffee/index.coffee']
        options:
          transform: [
            ['browserify-coffeelint', {
              doEmitErrors: true
            }]
            'caching-coffeeify'
            ['conditionalify', {
                context: buildTimeConfig
                marker: '#'
                exts: [ 'coffee' ]
            }]
            'require-globify'
            'csonify'
            'uglifyify'
          ]
      build:
        files:
          'build/js/index.js': ['src/coffee/index.coffee']
        options:
          transform: [
            ['browserify-coffeelint', {
              doEmitErrors: true
            }]
            'caching-coffeeify'
            ['conditionalify', {
                context: buildTimeConfig
                marker: '#'
                exts: [ 'coffee' ]
            }]
            'require-globify'
            'csonify'
          ]

    stylus:
      build:
        options:
          compress: false
        files:
          "build/css/style.css": "src/stylus/index.stylus"
      release:
        options:
          compress: true
        files:
          "release/css/style.css": "src/stylus/index.stylus"

    watch:
      options:
        livereload: false
      coffee:
        files: ['src/coffee/**/*.coffee']
        tasks: ['browserify:build']
      stylus:
        files: ['src/stylus/**/index.stylus']
        tasks: 'stylus:build'
      jade:
        files: ['src/jade/**/index.jade']
        tasks: 'jade:build'
      js:
        files: ['src/vendor/js/**/*.js']
        tasks: 'copy:build'
      css:
        files: ['src/vendor/css/**/*.css']
        tasks: 'copy:build'
      build:
        files: ['src/BuildConfig.cson']
        tasks: 'build'

    concat:
      release:
        options:
          banner: """<!--
          <%= meta.banner %>
          -->"""
        src:  'release/index.html'
        dest: 'release/index.html'

    htmlmin:
      release:
        options: releaseHtmlMinGeneralConfig
        files:
          [{
            expand: true
            cwd: 'release/'
            src: ['*.html', '!*.min.html']
            dest: 'release/'
            ext: '.html'
          }]
      release_standalone:
        options: releaseHtmlMinGeneralConfig
        files:
          [{
            expand: true
            cwd: 'release-standalone/'
            src: ['index.html']
            dest: 'release-standalone/'
            ext: '.html'
          }]
      dev:
        files:
          [{
            expand: true
            cwd: 'release/'
            src: ['**/*.html', '!**/*.min.html']
            dest: 'release/'
            ext: '.html'
          }]

    cssmin:
      release_standalone:
        options: {
          keepSpecialComments: 0
        }
        files: [{
          expand: true
          cwd: 'release/'
          src: ['**/*.css', '**/*.min.css']
          dest: 'release/'
          ext: '.css'
        }]
      release:
        files: [{
          expand: true
          cwd: 'release/'
          src: ['**/*.css', '**/*.min.css']
          dest: 'release/'
          ext: '.css'
        }]

    assets_inline:
      release_standalone:
        options:
          minify: true
          inlineImg: true
          inlineSvg: true
          inlineSvgBase64: true
          inlineLinkTags: false
          jsTags:
            start: '<script type="text/javascript">'
            end: '</script>'
        files:
           './release-standalone/index.html': './release/index.html'

    inline:
      release_standalone:
        options:
          tag: ''
          uglify: true
          cssmin: true
          inlineTagAttributes:
            js: 'data-inlined="true"'
            css: 'data-inlined="true"'
        src: './release/index.html'
        dest: './release-standalone/index.html'

    uglify:
      release_standalone:
        options:
          maxLineLen: 0
          banner: '<%= meta.banner %>'
          mangle: false
          mangleProperties: false
          reserveDOMProperties: false
          preserveComments: false
          compress: {
            sequences: 1000
            properties: true
            dead_code: true
            drop_debugger: true
            unsafe: true
            unsafe_comps: true
            conditionals: true
            comparisons: true
            evaluate: true
            booleans: true
            loops: true
            unused: true
            hoist_funs: true
            if_return: true
            join_vars: true
            cascade: true
            collapse_vars: true
            warnings: true
            negate_iife: true
            pure_getters: true
            drop_console: true
            keep_fargs: false
            keep_fnames: false
            passes: 1
          }
        files: [{
          expand: true
          cwd: 'release/'
          src: ['./js/index.js']
          dest: 'release/'
          ext: '.js'
        }]
      release:
        options:
          maxLineLen: 0
          banner: '<%= meta.banner %>'
        files: [{
          expand: true
          cwd: 'release/'
          src: ['**/*.js', '**/*.min.js']
          dest: 'release/'
          ext: '.js'
        }]

    connect:
      server:
        options:
          livereload: false
          base:
            path: 'build'
            options:
              index: 'index.html'
          port: 3000

    githubPages:
      standalone:
        options:
          commitMessage: "Auto-generated commit #{datetime.create().format('m/d/y H:M')}"
        src: 'release-standalone'

    'gh-pages':
      options:
        base: 'release-standalone'
        repo: config.repository.url
        message: "Auto-generated commit #{datetime.create().format('m/d/y H:M')}"
        user: config.authorUser
      src: ['*']

    file_info:
      standalone:
        src: './release-standalone/index.html'
        options:
          stdout:
            'Name: {{= filename(src) }}' + grunt.util.linefeed +
            'Date: {{= modified(src).toDateString() }}' + grunt.util.linefeed +
            'Size: {{= sizeText(size(src)) }}'
  }
