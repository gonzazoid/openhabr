#!/bin/sh

cd "/www/openhabr.net.$1/node"

pids="/www/openhabr.net.$1/pids"
logs="/www/openhabr.net.$1/logs"

forever -a -l "$logs/all.log"       --pidFile "$pids/all.pid"        stop all.js
forever -a -l "$logs/post.log"      --pidFile "$pids/post.pid"       stop post.js
forever -a -l "$logs/register.log"  --pidFile "$pids/register.pid"   stop register.js
forever -a -l "$logs/users.log"       --pidFile "$pids/users.pid"    stop users.js
forever -a -l "$logs/auth.log"       --pidFile "$pids/auth.pid"      stop auth.js
forever -a -l "$logs/posts.log"       --pidFile "$pids/posts.pid"      stop posts.js
forever -a -l "$logs/json.log"       --pidFile "$pids/json.pid"      stop json.js
