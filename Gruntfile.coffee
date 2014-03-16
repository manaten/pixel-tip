module.exports = (grunt)->
  pkg = grunt.file.readJSON 'package.json'
  grunt.initConfig
    pkg: pkg

    clean:
      dist: ["dst/*"]

    compass:
      dist:
        options:
          config: 'config.rb'

    csscomb:
      comb:
        expand: true,
        cwd: 'dst/',
        src: ['*.css'],
        dest: 'dst/'

    cssmin:
      all:
        expand: true,
        cwd: 'dst/',
        src: ['*.css'],
        dest: 'dst/'

    browserify:
      dist:
        files:
          'dst/pixel-tip.js': ['src/coffee/main.coffee'],
        options:
          transform: ['coffeeify']

    uglify:
      main:
        src:  'dst/pixel-tip.js',
        dest: 'dst/pixel-tip.js'

    watch:
      coffee:
        files: ['src/coffee/**/*', 'src/sass/**/*', 'src/image/**/*']
        tasks: ['compile']

  (grunt.loadNpmTasks task if task.match /^grunt\-/) for task of pkg.devDependencies

  grunt.registerTask 'compile', ['browserify', 'compass', 'csscomb']
  grunt.registerTask 'compile-min', ['compile', 'uglify', 'cssmin']
  grunt.registerTask 'default', ['watch']
