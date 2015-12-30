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
//экстеншины просто скопируем (можно это и deploy.sh засунуть, но если что то изменится - надо будет еще вспомнить что они в deploe затрагиваются
});

gulp.task("master", function(){
    //сборка (includes)
	//собираем клиента
	//серверы (для ноды)
	//конфигурации (пока только nginx)
	//все что в static, io.js и configs
    gulp.src("src/io.js/*.js")
	.pipe(nano(config.draft))
        .pipe(rigger())
        .pipe(gulp.dest("build/io.js/"));
//экстеншины просто скопируем (можно это и deploy.sh засунуть, но если что то изменится - надо будет еще вспомнить что они в deploe затрагиваются
    gulp.src("src/io.js/ext/*.js")
        .pipe(gulp.dest("build/io.js/ext/"));

//ок, сервер собрали, соберем клиента (это вообще надо повесить на bower)
    gulp.src("src/static/*.html")
	.pipe(nano(config.draft))
        .pipe(rigger())
        .pipe(gulp.dest("build/static/"));
//также надо разделить код тестирования, что бы на продуктиве он не копировался
    gulp.src("src/static/js/*.*")
        .pipe(gulp.dest("build/static/js/"));
    gulp.src("src/static/js/webcomponents/**/*.*")
        .pipe(gulp.dest("build/static/js/webcomponents/"));
//и картинки тоже
    gulp.src("src/static/img/**/*.*")
        .pipe(gulp.dest("build/static/img/"));

    gulp.src("src/configs/nginx.master.config")
	.pipe(nano(config.draft))
        .pipe(gulp.dest("build/configs/"));
});
