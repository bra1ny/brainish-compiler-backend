module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    clean: ['jsh/', 'jsh_test'],
    coffee: {
      compile: {
        expand: true,
        cwd: 'src',
        src: ['**/*.coffee'],
        dest: 'jsh/',
        ext: '.js'
      },
      compile: {
        expand: true,
        cwd: 'test',
        src: ['**/*.coffee'],
        dest: 'jsh_test/',
        ext: '.js'
      }
    },
    nodeunit: {
      all: ['jsh_test/**/*_test.js']
    },
  });

  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-nodeunit');

  grunt.registerTask('default', ['clean', 'coffee']);
  grunt.registerTask('test', ['clean', 'coffee', 'nodeunit']);
}
