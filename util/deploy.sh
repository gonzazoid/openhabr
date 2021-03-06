#!/usr/local/bin/bash

cd ../
rm -rf "/www/openhabr.net.$1"
cp -R "./openhabr.net.$1" /www/
cd  "/www/openhabr.net.$1"
mkdir logs
mkdir pids
mkdir build
# обновим модули ноды, вдруг что поменялось в package.json
# TODO тут бы тоже сравнивать с предыдущей версией и обновляться только на изменения
# (или сохранять скачанные в прошлый раз модули)
npm install
#запустить gulp
gulp "$1"

#и растасовать результаты сборки
cp -R build/node ./
cp -R node_modules ./node/

cp -R build/static ./

#также, если изменились конфиги - перезапустить соотв. службы
df=$(diff "/usr/local/etc/nginx/openhabr.conf" "conf/nginx.conf" | wc -L | sed 's/^[ \t]*//;s/[ \t]*$//')
echo "nginx config diff: $df"
if [ "$df" != "0" ]
then
cp "conf/nginx.conf"  "/usr/local/etc/nginx/openhabr.conf"
service nginx restart
fi

./restart $1

exit
