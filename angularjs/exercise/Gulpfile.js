var gulp = require('gulp');
var coffee = require('gulp-coffee');

gulp.task('coffee', function() {
  gulp.src('./source/Main.coffee')
    .pipe(coffee({bare: true}).on('error', console.log))
    .pipe(gulp.dest('./public/js'));
});

gulp.task('watch', function (){
	gulp.watch('source/**/*.coffee', ['coffee']);
});

