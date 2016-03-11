## Установка
1. node.js  
`curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash`  
Дальше можно либо перезапустить терминал, либо сделать `source ~/.nvm/nvm.sh`  
`nvm install 4`  
`nvm alias default 4`  
node.js установлен
2. openhabr  
Нам понадобится [cross-env](https://github.com/kentcdodds/cross-env) и [nodemon](https://github.com/remy/nodemon)  
`npm install -g cross-env nodemon`  
`git clone https://github.com/gonzazoid/openhabr.git && cd openhabr`  
`npm install`
3. postgresql

    ```
    sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
    wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | sudo apt-key add -
    sudo apt-get update
    sudo apt-get install postgresql postgresql-contrib
    sudo -u postgres psql postgres
    \password postgres # и введите 12345 например
    sudo -u postgres psql < models/dump.sql
    sudo -u postgres psql < node_modules/connect-pg-simple/table.sql
    ```
4. настройки  
Доступные настройки можно увидеть [здесь](https://github.com/gonzazoid/openhabr/config/index.js)  
Они задаются через переменные окружения.  
Например, чтобы поменять параметры подключения к postresql, достаточно ввести в терминале  
`export POSTGRES_URL=postgres://ordnung:atilla0453@localhost/habr` и перезапустить приложение  
5. запуск  
`npm start`
