// не пишите мне о том что я расшарил файл с паролем от базы если у вас нет четкого сценария как это использовать :)
const config = {
  postgresURL: process.env.POSTGRES_URL || 'postgres://postgres:12345@localhost/postgres',
  ip: process.env.IP || '127.0.0.1',
  port: process.env.PORT || 7000,
  secret:  process.env.SECRET || '12345'
};

export default config;
