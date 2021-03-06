# openhabr
openhabr.net engine

В общем это движок открытого хабра - [openhabr.net](http://openhabr.net/)

Открытого в том смысле что сообщество (если таковое соберется) - само будет решать, куда развивать проект. Само внедрять нужные фишки, голосованием принимать или отклонять пулл-реквесты и прочая демократия. Звучит конечно утопично, но может сначала попробуем?

Пока все простенько, на коленках, лишь бы работало.
(я там немного express добавил, пока не отобразил этот момент в документации)
Если хотите присоединиться - буду только рад.

Ниже - курс молодого бойца для желающих поразвивать проект. Здесь - только детали реализации движка. Если интересуют подробности устройства сообщества, правила, идеи и прочее - можно посмотреть здесь http://openhabr.net/post/1/

Стек проекта - nginx, node.js (+express), postgresql (9.4, но конечно буду переходить на  9.5, upsert-ы же), шаблонизатор - [mustache](https://github.com/janl/mustache.js)

Для начала структура проекта:

в корне лежат утилиты для деплоя и директории dev и src.

- [/dev/] (https://github.com/gonzazoid/openhabr/blob/master/dev) стафф для разработчиков
    - [example.js](https://github.com/gonzazoid/openhabr/blob/master/dev/example.js) - шаблон серверного скрипта, на базе которого можно писать свои скрипты.
    - [example.tpl](https://github.com/gonzazoid/openhabr/blob/master/dev/example.tpl) - типовой mustache-шаблон, "рыба" страницы.
- [/src/](https://github.com/gonzazoid/openhabr/tree/master/src) содержит все исходники сайта
    - [node/](https://github.com/gonzazoid/openhabr/tree/master/src/node) - серверные скрипты и mustache-шаблоны
    - [sql/](https://github.com/gonzazoid/openhabr/tree/master/src/sql) - структура базы и хранимые процедуры, дамп структуры базы лежит в [/src/sql/dump.sql](https://github.com/gonzazoid/openhabr/tree/master/src/sql)
    - [static/](https://github.com/gonzazoid/openhabr/tree/master/src/static) - все что отдается nginx-ом самостоятельно (css, шрифты, картинки, клиентские скрипты)

Собственно все. Теперь перейдем на сайт [openhabr.net](http://openhabr.net/). Да, верстка вся временно позаимствована, это нехорошо, я знаю. Как руки дойдут - поменяю, а еще лучше если найдется волонтер-верстальщик, который прикрутит нормальную (не позаимствованную) верстку.

Обратите внимание на красные ссылки - эти разделы еще не реализованы. Например раздел "хабы" в футере страницы. Ок, сделаем доброе дело, поможем проекту - реализуем вывод списка хабов по ссылке /hubs/.
Исходим из того что сам проект у нас уже форкнут и развернут.

Смотрим в оригинале - на этой странице выводится список хабов отсортированный в порядке убывания рейтинга хаба. На каждый хаб выводится: число подписчиков, количество публикаций, до 10-ти популярных тем и индекс хаба.

Что же, создадим скрипт, дергающий это все с базы и отдающий пользователю.
Итак, мы хотим реализовать вывод по адресу /hubs/.
- Откроем [/conf/nginx.conf](https://github.com/gonzazoid/openhabr/blob/master/conf/nginx.conf) Как видим, в списке локаций /hubs/ отсутствует, а значит нужна новая нода.
- Скопируем [/dev/example.js](https://github.com/gonzazoid/openhabr/blob/master/dev/example.js) в директорию [/src/node/](https://github.com/gonzazoid/openhabr/tree/master/src/node) под именем hubs.js (логично)
- пропишем ноду в nginx-е, добавив следующие строки: 

<pre>
location /hubs/ {
    proxy_pass http://localhost:7506/;
}
</pre>
Порт берем первый свободный, некритично. В дальнейшем это будет автоматом прописываться при сборке gulp-ом, пока так, не страшно.
- пропишем новую ноду в start и stop скриптах:
  в start добавим строку:

`forever -a --minUptime 1000 --spinSleepTime 1000  -l "$logs/hubs.log"       --pidFile "$pids/hubs.pid"       start hubs.js`

в stop:

`forever -a -l "$logs/hubs.log"       --pidFile "$pids/hubs.pid"      stop hubs.js`

Все, нода прописана, можно приступить к программированию. Открываем /src/node/hubs.js

nginx ждет ноду на 7506-ом порту, пропишем сразу это в ноде. В конце файла у нас есть строка запуска http сервера - заменим вопросительные знаки нашим портом:

<pre>
http.createServer(dispatcher).listen(7506, "localhost");
console.log('hubs.server running at http://localhost:7506');
</pre>

Разберемся теперь со структурой сервера. Посмотрим наш скрипт (/src/node/hubs.js) с самого начала:

```javascript
var patterns = {
    some_pattern: fs.readFileSync("./tpl/some_pattern.tpl", "utf-8")
   ,footer: fs.readFileSync("./tpl/footer.tpl", "utf-8")
};
```

Здесь мы загружаем нужные нам при работе паттерны.  Футер есть у всех страниц, его оставляем, помимо этого нам видимо понадобится шаблон списка хабов. Ок, заменим строку 

`    some_pattern: fs.readFileSync("./tpl/some_pattern.tpl", "utf-8")`

на 

`    hubs: fs.readFileSync("./tpl/hubs.tpl", "utf-8")`

В голове держим что в директорию /src/node/tpl/ надо добавить шаблон hubs.tpl, к этому моменту мы еще вернемся.

Смотрим дальше. Функция dispatcher - наш обработчик http запроса, на входе два объекта - request и response, все как обычно, если что то непонятно - смотрим [документацию](https://nodejs.org/api/http.html)

А вот в самом диспетчере мы объединяем request и response в один объект job `{request: request, response: response}`. Почему? Потому что мы делаем конвейер и каждый этап обработки запроса или ответа выносим в отдельную функцию, а что бы нормально chain-ить эти функции - удобно работать с одним объектом и передавать его по очереди, чем с двумя и делать их глобалами. Кроме того - один объект легко поддается промисизации, что и было реализовано.

Что же, смотрим доставшийся нам dispatcher. Подгружаемый модуль bike - это наш велосипед, в котором реализованы общие этапы обработки запроса.
- `prepare_headers` - готовит хидеры ответа, в основном убираем кэширование, в дальнейшем возможно изменим. Тут ничего трогать не надо, если вдруг нужны какие то особые хидеры - их можно добавить на любом этапе.
- `parse_cookies` - парсит куки и складывает их в job.request.cookies, ничего необычного
- `start_session` - на основании полученных кук запускает сессию - тупо подтягивает запись из таблицы users и кладет ее в job.request.user
- `worker` - а это как раз наш обработчик, который мы сейчас начнем реализовывать
- `output` - на основании подготовленных нами данных выводит всю верстку на клиента. Ожидает:
    - `job.response.habr.headers` - хидеры для вывода. Если переменная job.response.habr.status не указана, то выводит эти заголовки со статусом 200 Ok, иначе берет из job.response.habr.status.code и job.response.habr.status.message 
    - `job.response.habr.pattern` - шаблон страницы. Если не указан - вывод не осуществляется (например при редиректах)
    - `job.response.habr.patterns` - вспомогательные шаблоны. Сюда обычно присваивается переменная patterns, в которую грузятся все шаблоны перед стартом сервера (выше мы рассматривали ее)
    - `job.response.habr.data` - данные для заполнения шаблонов. Собственно наша работа заключается в том что бы эти данные подготовить. 

Таким образом, мы видим что все этапы обработки реализованы в bike, кроме собственно подготовки данных. Что же, начнем уже писать код.
Каждый обработчик в цепочке возвращает promise, который впоследствии резолвит в job. Этот код уже реализован в шаблоне, кроме того - подгружен модуль [pg](https://github.com/brianc/node-postgres) для коннекта к postgres и config, в котором хранится конфигурация сайта. В нашем случае нас интересует только строка коннекта к postgreSql, она хранится в config.common.postgres

Ок, добавим в шаблон такой код:

```javascript
    pg.connect(config.common.postgres, function (err, pgClient, done) {
	    if(err){
            console.log(err);
            reject();
    	    return;
	    }

        var sql = "какой то sql запрос"
        pgClient.query({
            text: sql
	       // ,values: argv
	    }, function(err, result){
            done();
	        if(err){
		        console.log(err);
                reject();
		        return;
	        }
	        //здесь в result.rows имеем результат запроса
	    });
	});
```

я планирую перейти на [pg-then](https://github.com/coderhaoxin/pg-then) и шаблонизировать работу с базой (но не ORM), но пока так, по колхозному, на коллбэках и ручками.

Как видим, в случае какой либо ошибки (при коннекте либо запросе) мы сразу пишем ошибку в лог и вызываем reject. Если мы посмотрим на цепочку вызовов в dispatcher, то увидим что обработчиком ошибок у нас везде указан `error`, это хандлер с велосипеда (`/src/node/bike.js`), он просто возвращает 500 Internal Server Error. Если нужно другое поведение - надо просто реализовать свой обработчик ошибки и указать его в цепочке вызовов.

Ок, давайте составим запрос. Заглянем в базу. Как видим, таблица hubs уже создана и имеет следующую структуру:

 id (bigint) | name (character varying) | title (character varying) 
-------------|--------------------------|---------------------------

В комментариях видим что name используется в url и англоязычный, title выводится в тексте и может быть на любом языке. Заглянем на сайт, посмотрим вывод любой статьи, например [этой](http://openhabr.net/post/1/). Видим список хабов под заголовком статьи, например "первый хаб", который ссылается на http://openhabr.net/hub/first/ . Понимаем что "первый хаб" это title, "first" - name. В этом можно убедиться, посмотрев шаблон статьи - /src/node/tpl/article.tpl (надо бы переименовать в post.tpl)
Ок, с тем что есть в базе - определились. Но нам надо больше:
>На каждый хаб выводится: число подписчиков, количество публикаций, до 10-ти популярных тем и индекс хаба.

Ничего из этого списка у нас нет. Не проблема - добавим.

- число подписчиков, тут понятно, будет целое число. Можно не хранить это число вообще, каждый раз считая по подпискам в таблице users, но это усложнит запрос и нагрузит базу. Проще хранить заранее подсчитанное число и выводить простым запросом. Но в этом случае в коде подписчика надо будет предусмотреть инкремент этого числа. Ок.
- количество публикаций - аналогично. Целое число, в коде публикации предусмотреть инкремент
- 10 популярных тем. Озадачиваемся вопросом - что такое популярная публикация и выясняем что это ни что ионое как теги, те самые теги к статье которые никто не читает. Отлично, значит это будет массив id-ишнников тегов. Таблица тегов в базе уже есть, отлично.
- индекс хаба (он же рейтинг). Пока что нет алгоритма, как он будет рассчитываться, но понятно что это не целое а real.

Ну ок, добавляем эти поля в таблицу hubs (я это сделал в phpPgAdmin-е, вы можете это сделать любым удобным вам способом). Теперь таблица имеет вид:

 id (bigint) | name (character varying) | title (character varying) | subscribers (integer) | posts (integer) | popular (bigint[]) | rating (real) |
-------------|--------------------------|---------------------------|-----------------------|-----------------|------------------------|---------------|

Получается нам надо сделать банальную выборку по hubs, отсортированную по rating, в порядке убывания, первые 40 записей. Подтянув попутно для popular их titles из таблицы tags.

Строим sql запрос:

```sql
SELECT hubs.*, m.tag_id, m.tag_title
FROM (
    WITH maximums AS(
        SELECT id, popular
        FROM hubs
        ORDER BY rating DESC
        LIMIT 40
    )
    SELECT maximums.id, array_agg(tags.id) AS tag_id, array_agg(tags.title) AS tag_title
    FROM maximums 
    LEFT OUTER JOIN tags ON (tags.id = ANY(maximums.popular))
    GROUP BY maximums.id
) m, hubs
WHERE m.id = hubs.id
ORDER BY rating DESC;
```

Казалось бы, что может быть проще :)

Совать эту простыню с js как то не комильфо, давайте оформим хранимкой, заодно сделав пагинацию и число выводимых хабов:

```sql
--
-- Name: get_hubs(integer, integer); Type: FUNCTION; Schema: public; Owner: openhabr
--

DROP FUNCTION IF EXISTS get_hubs(integer, integer);

CREATE FUNCTION get_hubs(_count integer, _offset integer) 
RETURNS TABLE(id bigint
             ,name character varying
             ,title character varying
             ,subscribers integer
             ,posts integer
             ,popular bigint[]
             ,rating real
             ,tag_id bigint[]
             ,tag_title character varying[]
             )
    LANGUAGE sql
    AS $$

SELECT hubs.*, m.tag_id, m.tag_title
FROM (
    WITH maximums AS(
        SELECT id, popular
        FROM hubs
        ORDER BY rating DESC
        LIMIT _count
        OFFSET _offset
    )
    SELECT maximums.id, array_agg(tags.id) AS tag_id, array_agg(tags.title) AS tag_title
    FROM maximums 
    LEFT OUTER JOIN tags ON (tags.id = ANY(maximums.popular))
    GROUP BY maximums.id
) m, hubs
WHERE m.id = hubs.id
ORDER BY rating DESC;

$$;

ALTER FUNCTION public.get_hubs(integer, integer) OWNER TO openhabr;
```
сохраняем это дело в виде  /src/sql/functions/get_hubs.sql, дамп базы в таком раскладе можно не сохранять, я все равно ручками добавлю при слиянии.

Что хочу отметить - очень плохо, что мы делаем select hubs.* а в возвращаемом типе перечисляем явно все поля hubs - стоит нам добавить новое поле в hubs и мы попадаем на правку возвращаемого типа функции. Быть может есть решение этого вопроса?

Трудно сказать, планировщику постгреса по любому надо заранее знать состав возвращаемой таблицы. Но мы можем не выбирать .*, а указать конкретные поля, мы то знаем точно, что выводим. В таком случае, если в дальнейшем в таблицу hubs будут добавлены столбцы, они нам не поломают ни функцию ни вывод страницы. А если добавляемые столбцы надо будет выводить на этой странице - мы полюбому полезем править шаблон, а с него через скрипт дойдем и до хранимки. Ок, делаем правильно:

```sql
--
-- Name: get_hubs(integer, integer); Type: FUNCTION; Schema: public; Owner: openhabr
--

DROP FUNCTION IF EXISTS get_hubs(integer, integer);

CREATE FUNCTION get_hubs(_count integer, _offset integer) 
RETURNS TABLE(id bigint
             ,name character varying
             ,title character varying
             ,subscribers integer
             ,posts integer
             ,popular bigint[]
             ,rating real
             ,tag_id bigint[]
             ,tag_title character varying[]
             )
    LANGUAGE sql
    AS $$

SELECT hubs.id
       ,hubs.name
       ,hubs.title
       ,hubs.subscribers
       ,hubs.posts
       ,hubs.popular
       ,hubs.rating
       ,m.tag_id
       ,m.tag_title
FROM (
    WITH maximums AS(
        SELECT id, popular
        FROM hubs
        ORDER BY rating DESC
        LIMIT _count
        OFFSET _offset
    )
    SELECT maximums.id, array_agg(tags.id) AS tag_id, array_agg(tags.title) AS tag_title
    FROM maximums 
    LEFT OUTER JOIN tags ON (tags.id = ANY(maximums.popular))
    GROUP BY maximums.id
) m, hubs
WHERE m.id = hubs.id
ORDER BY rating DESC;

$$;

ALTER FUNCTION public.get_hubs(integer, integer) OWNER TO openhabr;
```

Совсем другое дело, не стыдно и соседям показать.

Что же, вернемся к нашему скрипту. Sql запрос у нас деградирует до следующего:
```sql
SELECT * FROM get_hubs(40, 0);
```
Запрашиваем первые 40 записей (по рейтингу). В дальнейшем можно использовать эту же функцию для пагинации.

Таким образом наш скрипт принимает вид:

```javascript
"use strict";
//просто что бы видеть, какие модули используются
["http", "fs", "pg", "mustache", "./bike", "./config"].forEach(cV => require(cV));

var fs = require("fs");
var http = require("http");

var patterns = {
    hubs: fs.readFileSync("./tpl/hubs.tpl", "utf-8")
   ,footer: fs.readFileSync("./tpl/footer.tpl", "utf-8")
};

var dispatcher = function(request, response){

    var fw = require("./bike");

         fw.prepare_headers({request, response})
   .then(fw.parse_cookies, fw.err)
   .then(fw.start_session, fw.err)
   .then(worker, fw.err)
   .then(fw.output, fw.err);
};

var worker = function(job){
    console.log("worker", job);
    return new Promise(function(resolve, reject){
        //TODO перевести на pg-then
        var pg = require("pg");
        var config = require("./config");
        pg.connect(config.common.postgres, function (err, pgClient, done) {
            if(err){
                console.log(err);
                reject();
                return;
            }
            //TODO - 40 перенести в config (число хабов выводимых на одной странице списка)
            var sql = "SELECT * FROM get_hubs(40, 0);"
            pgClient.query({
                text: sql
                // ,values: argv
            }, function(err, result){
                done();
                if(err){
                    console.log(err);
                    reject();
                    return;
                }
                //здесь в result.rows имеем результат запроса
            });
        });
    });
};

http.createServer(dispatcher).listen(7506, "localhost");
console.log('hubs.server running at http://localhost:7506');
```
Отлично! В result.rows имеем результат запроса, надо его правильно передать шаблонизатору. Для начала сольем вместе tag_id и tag_title, так, что бы это был массив элементов `{id: "", title: ""}`, это позволит последовательно выводить в шаблонизаторе. Также обратите внимание - в tag_id и tag_title они идут не в том порядке нежели указано в popular, а ведь порядок в данном случае имеет значение - предполагается что теги выводятся в порядке убывания популярности (алгоритм ранжирования мы оставляем за бортом, здесь только вывод информации).

Возможно есть способ собрать это все внутри sql запроса, но я, как говорится, "ниасилил" без циклов, а циклы как то в sql не хочется. Возможно в mustache можно, перебирая один массив подтягивать элементы другого (индекc то доступен) - не пробовал, но если это возможно - можно полностью убрать растасовку. Надеюсь более опытные коллеги предложат более элегантное решение.

Что же, пройдемся по массиву:

```javascript
var tags = {};
for(i=0, l=tag_id.length; i<l; i++){
    tags[tag_id[i]] = {id: tag_id[i], title: tag_title[i]};
}
```

На выходе имеем *объект* tags, в котором собраны теги, причем каждый тег занесен под своим id.

Перенесем теперь теги в массив popular результатов запроса (для каждого хаба) и заменим в нем id тега на сам тег:
```javascript
for(i=0, l=popular.length; i<l; i++){
    popular[i] = tags[popular[i]];
}
```

Теперь можно удалить tag_id и tag_title - они уже не нужны, И! Данный код надо оформить для каждой строки из result.rows, то есть вложить в цикл. Итоговый вариант будет выглядеть так:

```javascript
result.rows.forEach(cv => {
    var tag_id = cv.tag_id;
    var tag_title = cv.tag_title;
    var popular = cv.popular;
    var tags = {};
    for(i=0, l=tag_id.length; i<l; i++){
        tags[tag_id[i]] = {id: tag_id[i], title: tag_title[i]};
    }
    for(i=0, l=popular.length; i<l; i++){
        popular[i] = tags[popular[i]];
    }
});
```
Можно конечно и циклы заменить на forEach и map.
```javascript
result.rows.forEach(cv => {
    var tag_id = cv.tag_id;
    var tag_title = cv.tag_title;
    var popular = cv.popular;
    var tags = {};
    tag_id.forEach((cv, i) => {
        tags[cv] = {id: cv, title: tag_title[i]};
    });
    popular.forEach( (cv, i) => {
        popular[i] = tags[cv];
    });
});
```
Ну и уберем лишние транзитные переменные - станет полаконичнее (главное не переусердствовать)
```javascript
result.rows.forEach(cv => {
    var tags = {};
    cv.tag_id.forEach((cur, i) => {
        tags[cur] = {id: cur, title: cv.tag_title[i]};
    });
    cv.popular.forEach( (cur, i) => {
        cv.popular[i] = tags[cur];
    });
});
```

Можно и дальше покуралесить, но особо нужды не вижу.
Ок, наш скрипт приобретает такой вид:
```javascript
"use strict";
//просто что бы видеть, какие модули используются
["http", "fs", "pg", "mustache", "./bike", "./config"].forEach(cV => require(cV));

var fs = require("fs");
var http = require("http");

var patterns = {
    hubs: fs.readFileSync("./tpl/hubs.tpl", "utf-8")
   ,footer: fs.readFileSync("./tpl/footer.tpl", "utf-8")
};

var dispatcher = function(request, response){

    var fw = require("./bike");

         fw.prepare_headers({request, response})
   .then(fw.parse_cookies, fw.err)
   .then(fw.start_session, fw.err)
   .then(worker, fw.err)
   .then(fw.output, fw.err);
};

var worker = function(job){
    console.log("worker", job);
    return new Promise(function(resolve, reject){
        //TODO перевести на pg-then
        var pg = require("pg");
        var config = require("./config");
        pg.connect(config.common.postgres, function (err, pgClient, done) {
            if(err){
                console.log(err);
                reject();
                return;
            }
            //TODO - 40 перенести в config (число хабов выводимых на одной странице списка)
            var sql = "SELECT * FROM get_hubs(40, 0);"
            pgClient.query({
                text: sql
                // ,values: argv
            }, function(err, result){
                done();
                if(err){
                    console.log(err);
                    reject();
                    return;
                }
                //здесь в result.rows имеем результат запроса
                result.rows.forEach(cv => {
                    var tags = {};
                    cv.tag_id.forEach((cur, i) => {
                        tags[cur] = {id: cur, title: cv.tag_title[i]};
                    });
                    cv.popular.forEach( (cur, i) => {
                        cv.popular[i] = tags[cur];
                    });
                    delete cv.tag_title;
                    delete cv.tag_id;
                });
                //растасуем данные для заполнения и вывода шаблона
            });
        });
    });
};

http.createServer(dispatcher).listen(7506, "localhost");
console.log('hubs.server running at http://localhost:7506');
```
Ну все, данные причесаны, можно передать шаблонизатору и выводить уже пользователю.

Как выше уже говорилось:
>- `output` - на основании подготовленных нами данных выводит всю верстку на клиента. Ожидает:
>    - `job.response.habr.headers` - хидеры для вывода. Если переменная job.response.habr.status не указана, то выводит эти заголовки со статусом 200 Ok, иначе берет из job.response.habr.status.code и job.response.habr.status.message 
>    - `job.response.habr.pattern` - шаблон страницы. Если не указан - вывод не осуществляется (например при редиректах)
>    - `job.response.habr.patterns` - вспомогательные шаблоны. Сюда обычно присваивается переменная patterns, в которую грузятся все шаблоны перед стартом сервера (выше мы рассматривали ее)
 >   - `job.response.habr.data` - данные для заполнения шаблонов. Собственно наша работа заключается в том что бы эти данные подготовить. 

- `headers` у нас подготовлен, никаких особых хидеров мы не выставляем
- `pattern` не готов, надо прописать
- `patterns` грузили в начале скрипта, но нам надо вернутся туда и подготовить шаблон
- `data` ну собственно все содержимое result.rows

Ок, выглядеть это будет так:
```javascript
"data" in job.response.habr || (job.response.habr.data = {});
job.response.habr.data.hubs = result.rows;
job.response.habr.pattern = patterns.hubs;
job.response.habr.patterns = patterns;
resolve(job);
```
Один момент - мы присвоили result.rows не сразу в job.response.habr.data а в job.response.habr.data.hubs потому что в job.response.habr.data могут хранится и другие данные (например сессия перед выводом переносится в job.response.habr.data.user)

Собственно все!
Ну а окончательно наш скрипт будет выглядеть вот так:
<details><summary>/src/node/hubs.js</summary>
```javascript
"use strict";
//просто что бы видеть, какие модули используются
["http", "fs", "pg", "mustache", "./bike", "./config"].forEach(cV => require(cV));

var fs = require("fs");
var http = require("http");

var patterns = {
    hubs: fs.readFileSync("./tpl/hubs.tpl", "utf-8")
   ,footer: fs.readFileSync("./tpl/footer.tpl", "utf-8")
};

var dispatcher = function(request, response){

    var fw = require("./bike");

         fw.prepare_headers({request, response})
   .then(fw.parse_cookies, fw.err)
   .then(fw.start_session, fw.err)
   .then(worker, fw.err)
   .then(fw.output, fw.err);
};

var worker = function(job){
    console.log("worker", job);
    return new Promise(function(resolve, reject){
        //TODO перевести на pg-then
        var pg = require("pg");
        var config = require("./config");
        pg.connect(config.common.postgres, function (err, pgClient, done) {
            if(err){
                console.log(err);
                reject();
                return;
            }
            //TODO - 40 перенести в config (число хабов выводимых на одной странице списка)
            var sql = "SELECT * FROM get_hubs(40, 0);"
            pgClient.query({
                text: sql
                // ,values: argv
            }, function(err, result){
                done();
                if(err){
                    console.log(err);
                    reject();
                    return;
                }
                //здесь в result.rows имеем результат запроса
                result.rows.forEach(cv => {
                    var tags = {};
                    cv.tag_id.forEach((cur, i) => {
                        tags[cur] = {id: cur, title: cv.tag_title[i]};
                    });
                    cv.popular.forEach( (cur, i) => {
                        cv.popular[i] = tags[cur];
                    });
                    delete cv.tag_title;
                    delete cv.tag_id;
                });
                //растасуем данные для заполнения и вывода шаблона
                "data" in job.response.habr || (job.response.habr.data = {});
                job.response.habr.data.hubs = result.rows;
                job.response.habr.pattern = patterns.hubs;
                job.response.habr.patterns = patterns;
                resolve(job);
            });
        });
    });
};

http.createServer(dispatcher).listen(7506, "localhost");
console.log('hubs.server running at http://localhost:7506');
```
</details>

Осталось подготовить шаблон вывода.

Помните в самом начале работы мы правили код подгрузки шаблонов? Мы тогда еще сделали засечку:
>В голове держим что в директорию /src/node/tpl/ надо добавить шаблон hubs.tpl, к этому моменту мы еще вернемся.
Так вот пришло время вернуться к этому моменту. Сходим обратно в /dev/ и обратим внимание на example.tpl. Это шаблонный шаблон, так сказать. Скопируем его в /node/tpl/hubs.tpl и откроем.

Нам надо заменить {{your workflow}} на наш цикл вывода хабов. Поскольку цикл идет по массиву job.response.habr.data.hubs, который в mustache попадет как data.hubs, то цикл в шаблоне примет вид:
```html
{{#hubs}}
<!-- здесь наша верстка одного хаба -->
{{/hubs}}
```
Идем на хабр (я помню, нехорошо, но я не верстальщик, вместо того что бы осуждать - помогите :)

Так вот, идем и видим что та есть еще и заголовок. Верстку удобно дергать в хроме, с открытыми developers tools, на табе elements. Выделяем в верстке нужный элемент и по выделению сразу видим, что он отображает на странице. Не снимая выделения - ctr-c и верстка у нас в буфере.

C заголовком наш шаблон выглядит так:
```html
{{#hubs}}
    <div class="page_head">
      <h2 class="title">Хабы</h2>
    </div>
    <!-- здесь наша верстка одного хаба -->
{{/hubs}}
```

Таким же образом находим верстку всех хабов и копируем. Удаляем все хабы кроме одного, получаем что то вроде этого:
 ```html
<div class="hubs_list">
    <div class="hubs_suggest">
        <input type="text" id="hubs_suggest" autocomplete="off" placeholder="Найти хаб">
    </div>
    <div class="hubs_head">
        <div class="habraindex">индекс ↓</div>
        <div class="title">
            <a class="dotted" href="/hubs/?order=title">название ↓</a>
        </div>
    </div>
    <div class="hubs" id="hubs">
        <div class="hub subscribed" id="hub_50">
            <div class="habraindex">515,22</div>
            <div class="info">
                <div class="title">
                    <a href="http://habrahabr.ru/hub/infosecurity/">Информационная безопасность</a>
                    <span class="n-profiled_hub" title="Профильный хаб"></span>
                </div>
                <div class="buttons">
                  <input type="button" class="btn btn_subscribe hidden subscribeHub" value="Подписаться" data-id="50">
                  <input type="button" class="btn btn_subscribe btn_subscribed  unsubscribeHub" value="Подписан" data-id="50">
                </div>
                <div class="clear"></div>
                <div class="stat">
                    <a href="http://habrahabr.ru/hub/infosecurity/subscribers/" class="members_count">502k подписчиков</a>, <a href="http://habrahabr.ru/hub/infosecurity/posts/">5,3k публикаций</a>
                </div>
                <div class="common_tags">Популярные темы: 
                    <a href="http://habrahabr.ru/search/?q=%5B%D0%B8%D0%BD%D1%84%D0%BE%D1%80%D0%BC%D0%B0%D1%86%D0%B8%D0%BE%D0%BD%D0%BD%D0%B0%D1%8F+%D0%B1%D0%B5%D0%B7%D0%BE%D0%BF%D0%B0%D1%81%D0%BD%D0%BE%D1%81%D1%82%D1%8C%5D">информационная безопасность</a>,
                    <a href="http://habrahabr.ru/search/?q=%5B%D0%B1%D0%B5%D0%B7%D0%BE%D0%BF%D0%B0%D1%81%D0%BD%D0%BE%D1%81%D1%82%D1%8C%5D">безопасность</a>, <a href="http://habrahabr.ru/search/?q=%5B%D0%B2%D0%B7%D0%BB%D0%BE%D0%BC%5D">взлом</a>, <a href="http://habrahabr.ru/search/?q=%5Bsecurity%5D">security</a>,
                    <a href="http://habrahabr.ru/search/?q=%5B%D1%83%D1%8F%D0%B7%D0%B2%D0%B8%D0%BC%D0%BE%D1%81%D1%82%D1%8C%5D">уязвимость</a>, <a href="http://habrahabr.ru/search/?q=%5B%D1%83%D1%8F%D0%B7%D0%B2%D0%B8%D0%BC%D0%BE%D1%81%D1%82%D0%B8%5D">уязвимости</a>, <a href="http://habrahabr.ru/search/?q=%5Bgoogle%5D">google</a>,
                    <a href="http://habrahabr.ru/search/?q=%5B%D0%B2%D0%B8%D1%80%D1%83%D1%81%D1%8B%5D">вирусы</a>, <a href="http://habrahabr.ru/search/?q=%5Bandroid%5D">android</a>,
                    <a href="http://habrahabr.ru/search/?q=%5B%D0%BA%D1%80%D0%B8%D0%BF%D1%82%D0%BE%D0%B3%D1%80%D0%B0%D1%84%D0%B8%D1%8F%5D">криптография</a>
                </div>
            </div>
        </div> 
        <div class="page-nav">
            <ul class="next-prev">
                <li><span>←</span>&nbsp;сюда</li>
                <li><a title="На страницу вперед (Alt + →)" class="next" id="next_page" href="/hubs/page2/" rel="">туда</a>&nbsp;<span>→</span></li>
            </ul>
            <ul id="nav-pages">
                <li><em>1</em></li>
                <li><a href="/hubs/page2/">2</a></li>
                <li><a href="/hubs/page3/">3</a></li>
                <li><a href="/hubs/page4/">4</a></li>
                <li><a href="/hubs/page5/">5</a></li>
                <li><a href="/hubs/page6/">6</a></li>
                <li><a href="/hubs/page7/">7</a></li>
            </ul>
        </div>
    </div>
</div>
```
