# docker контейнер для проекта на yii2 - linux

- Кладём в корень с проектом Yii2 и переименовываем папку в docker
- docker-compose.yml и .env выносим из папки docker в корень проекта yii2



## Команды

```bash
  docker-compose up
  docker-compose down
```
- сайт достпен по адресу https://localhost
- phpmyadmin доступен по адресу http://localhost:8888

## Данные для соединения с базой данных db.php

```bash
   return [
      'class' => 'yii\db\Connection',
      'dsn' => 'mysql:host=mysql;dbname={your_db_name}',
      'username' => 'root',
      'password' => 'root',
      'charset' => 'utf8',
  ];
```
