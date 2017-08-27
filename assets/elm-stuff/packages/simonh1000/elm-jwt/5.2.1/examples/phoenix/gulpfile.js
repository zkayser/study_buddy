var	gulp           = require('gulp'),
	concat         = require('gulp-concat'),
	// browserSync    = require('browser-sync').create(),
	sourcemaps     = require('gulp-sourcemaps'),
	sass           = require('gulp-sass'),
	elm            = require('gulp-elm'),
	// production tools
    runSequence    = require('run-sequence'),
	gulpif         = require('gulp-if'),
	minifyCss	   = require('gulp-minify-css'),
	uglify         = require('gulp-uglify');

var paths = {
	dist    : "priv/static/",
	scss    : ['web/elm/sass/*.scss'],
	elm     : "web/elm/**/*.elm",
	elmMain : "web/elm/Main.elm"
};

var production = false;

/*
 * H T M L / C S S
 */

// runs jade on index.jade
gulp.task('html', function() {
	return gulp.src(paths.html)
	.pipe(jade({pretty: true}))
	.pipe(gulp.dest(paths.dist));
});

gulp.task('sass', function() {
	return gulp.src(paths.scss)
	.pipe(sass().on('error', sass.logError))
	.pipe(concat('app.css'))
	.pipe( gulpif(production, minifyCss()) )    // minify in production
	.pipe(gulp.dest(paths.dist + "/css"))
	// .pipe(browserSync.stream()); 			// injects new styles without page reload!
});

gulp.task('compilation', ['html', 'sass']);

/*
 * E L M
 */

 gulp.task('elm-init', elm.init);

 gulp.task('elm-compile', ['elm-init'], function() {
	 // By explicitly handling errors, we prevent Gulp crashing when compile fails
     function onErrorHandler(err) {
         console.log(err.message);
     }
     return gulp.src(paths.elmMain)             // "./src/Main.elm"
         .pipe(elm({debug: true}))
         .on('error', onErrorHandler)
		//  .pipe( gulpif(production, uglify()) )   // uglify
         .pipe(gulp.dest(paths.dist + "/js"));
 })

/*
 * D E V E L O P M E N T
 */

 gulp.task('watch', function() {
 // 	browserSync.init({
 // 		proxy: 'localhost:4000',
 // 	});

	gulp.watch(paths.html, ['html']);
	gulp.watch(paths.scss, ['sass']);
	gulp.watch(paths.elm, ['elm-compile']);
	// gulp.watch(paths.dist+"/*.{js,html}").on('change', browserSync.reload);
 });

/*
 * P R O D U C T I O N
 * T B C
 */
// var del = require('del');
// gulp.task('del', function(cb) {
// 	del(['./dist/*'])
// 	.then( () => cb() );
// });

gulp.task('build', function() {
// gulp.task('build', ['del'], function() {
	production = true;
	runSequence('compilation', 'elm-compile');
});
/*
 * A P I
 */
gulp.task('default', ['compilation', 'elm-compile', 'watch']);
