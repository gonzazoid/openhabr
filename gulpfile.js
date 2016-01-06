'use strict'

var gulp   = require("gulp")
   ,nano   = require("./gulp-nano")
;

gulp.task("draft", function(){
    //сборка (includes)
	//собираем клиента
	//серверы (для ноды)
	//конфигурации (пока только nginx)
	//все что в static, io.js и configs
    gulp.src("src/node/*.js")
//	.pipe(nano(config.draft))
        .pipe(gulp.dest("build/node/"));
    gulp.src("src/node/tpl/*.tpl")
        .pipe(gulp.dest("build/node/tpl/"));

    gulp.src("src/static/*.*")
        .pipe(gulp.dest("build/static/"));
    gulp.src("src/static/js/*.js")
        .pipe(gulp.dest("build/static/js/"));
    gulp.src("src/static/css/*.*")
        .pipe(gulp.dest("build/static/css/"));
    gulp.src("src/static/fonts/*.*")
        .pipe(gulp.dest("build/static/fonts/"));
    gulp.src("src/static/img/*.*")
        .pipe(gulp.dest("build/static/img/"));
    gulp.src("src/static/img/avatars/*.*")
        .pipe(gulp.dest("build/static/img/avatars/"));
});

gulp.task("master", function(){

});
