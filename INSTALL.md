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
`https://github.com/gonzazoid/openhabr && cd openhabr`  
`npm install`
3. postgresql 
```
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/`lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | sudo apt-key add -
sudo apt-get update
sudo apt-get install postgresql postgresql-contrib
```
