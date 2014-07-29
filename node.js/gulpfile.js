var gulp = require('gulp');
var coffee = require('gulp-coffee');
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');
var imagemin = require('gulp-imagemin');

var del = require('del');

var paths = {
  scripts: ['*.coffee'],
  images: 'img/**/*',
  destjs: 'public/js'
};

// Not all tasks need to use streams
// A gulpfile is just another node program and you can use all packages available on npm
gulp.task('clean', function(cb) {
  // You can use multiple globbing patterns as you would with `gulp.src`
  del(['public'], cb);
});

gulp.task('concat-coffee', ['clean'], function() {
  // Minify and copy all JavaScript (except vendor scripts)
  return gulp.src(paths.scripts)
    .pipe(coffee())
    .pipe(concat('all.min.js'))
    .pipe(gulp.dest(paths.destjs));
});

gulp.task('uglify', function() {
	// Minify and copy all JavaScript (except vendor scripts)
	return gulp.src(paths.scripts)
	.pipe(coffee())
	.pipe(uglify())
	.pipe(concat('all.min.js'))
	.pipe(gulp.dest(paths.destjs));
});


// Copy all static images
gulp.task('images', ['clean'], function() {
 return gulp.src(paths.images)
    // Pass in options to the task
    .pipe(imagemin({optimizationLevel: 5}))
    .pipe(gulp.dest('public/img'));
});


// Rerun the task when a file changes
gulp.task('watch', function() {
  gulp.watch(paths.scripts, ['scripts']);
  gulp.watch(paths.images, ['images']);
});

// The default task (called when you run `gulp` from cli)
gulp.task('debug', ['watch', 'scripts', 'images']);
gulp.task('release', ['watch', 'scripts', 'uglify' ,'images']);