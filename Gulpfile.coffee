gulp = require('gulp')
gutil = require('gulp-util')
coffee = require('gulp-coffee')
concat = require('gulp-concat')
uglify = require('gulp-uglify')
sass = require('gulp-sass')
ngAnnotate = require('gulp-ng-annotate')


gulp.task 'frontendScripts', ->
  gulp.src('./src/frontend/scripts/**/*.coffee')
    .pipe(coffee(bare: true).on('error', gutil.log))
    .pipe(ngAnnotate().on('error', gutil.log))
    .pipe(concat('index.js')).on('error', gutil.log)
    .pipe(uglify()).on('error', gutil.log)
    .pipe(gulp.dest('./dist/frontend/scripts/'))


gulp.task 'frontendStyles', ->
  gulp.src('./src/frontend/styles/main.scss')
    .pipe(sass()).on('error', gutil.log)
    .pipe(gulp.dest('./dist/frontend/styles/'))


gulp.task 'frontendViews', ->
  gulp.src('./src/frontend/views/**/*.html')
    .pipe(gulp.dest('./dist/frontend/views'))


gulp.task 'adminScripts', ->
  gulp.src('./src/admin/scripts/**/*.coffee')
    .pipe(coffee(bare: true).on('error', gutil.log))
    .pipe(ngAnnotate().on('error', gutil.log))
    .pipe(concat('index.js')).on('error', gutil.log)
    .pipe(uglify()).on('error', gutil.log)
    .pipe(gulp.dest('./dist/admin/scripts/'))


gulp.task 'watch', ->
  gulp.watch('./src/frontend/scripts/**/*.coffee', ['frontendScripts'])
  gulp.watch('./src/frontend/styles/**/*.scss', ['frontendStyles'])
  gulp.watch('./src/frontend/views/**/*.html', ['frontendViews'])
  gulp.watch('./src/admin/scripts/**/*.coffee', ['adminScripts'])


gulp.task 'build', ['frontendScripts', 'frontendStyles', 'frontendViews', 'adminScripts']


gulp.task 'default', ['build', 'watch']
