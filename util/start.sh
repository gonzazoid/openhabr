#!/usr/local/bin/bash

#usage start branch
cd "/www/openhabr.net.$1/node/"

pids="/www/openhabr.net.$1/pids"
logs="/www/openhabr.net.$1/logs"
#если draft - сбросить логи

forever -a --minUptime 1000 --spinSleepTime 1000  -l "$logs/all.log"       --pidFile "$pids/all.pid"       start all.js
forever -a --minUptime 1000 --spinSleepTime 1000  -l "$logs/post.log"       --pidFile "$pids/post.pid"       start post.js
forever -a --minUptime 1000 --spinSleepTime 1000  -l "$logs/register.log"       --pidFile "$pids/register.pid"       start register.js
forever -a --minUptime 1000 --spinSleepTime 1000  -l "$logs/users.log"       --pidFile "$pids/users.pid"       start users.js
forever -a --minUptime 1000 --spinSleepTime 1000  -l "$logs/auth.log"       --pidFile "$pids/auth.pid"       start auth.js
forever -a --minUptime 1000 --spinSleepTime 1000  -l "$logs/posts.log"       --pidFile "$pids/posts.pid"       start posts.js
forever -a --minUptime 1000 --spinSleepTime 1000  -l "$logs/json.log"       --pidFile "$pids/json.pid"       start json.js

# в prod-сборке этого быть не должно. Как это сделать?
#forever -a -l "$logs/$1/test.log"       --pidFile "$pids/$1/test.pid"       start test.server.js
