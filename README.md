<h1>Party Parrot App</h1>

<img src='media/images/party-parrot.gif' alt='parrot' height="200" width="200">
<br>
<br>
<h3></h3>

# Запуск проекта через docker-compose

Для запуска используйте docker и docker-compose. Подробнее о установке искать [тут](https://docs.docker.com/compose/install/).

## Сбор и запуск контейнеров
   ```shell
         docker-compose -f docker-compose.override.yml --env-file django.env up --build
   ```
* Все enviroments поля находятся в django.env
  Для ручной настройки
  ```shell
     EXPOSE DJANGO_DB_HOST=db
     EXPOSE DJANGO_DB_NAME=app
     EXPOSE DJANGO_DB_USER=worker
     EXPOSE DJANGO_DB_PASS=worker
     EXPOSE DJANGO_DB_PORT="5432"
     EXPOSE DJANGO_DEBUG="False"
  ```
  ```shell
     docker-compose -f docker-compose.override.yml up --build
  ```
____

## Зависимости 
- django 4.0.1
- Pillow 9.0.0
- psycopg2-binary 2.9.3
- django-prometheus 2.2.0
- uWSGI 2.0.20
<h3>Deployment</h3>

____
# Установка вручную

- install Python 3.8
- install libs 
```shell
      pip3 install -r requirements.txt
```

* Set environment export for variables:
```yaml
      DJANGO_DB_HOST: db
      DJANGO_DB_NAME: app
      DJANGO_DB_USER: worker
      DJANGO_DB_PASS: worker
      DJANGO_DB_PORT: "5432"
      DJANGO_DEBUG: "False"
```

* migrate database:
```shell
python3 manage.py migrate
```

* start application:
```shell
python3 manage.py uwsgi uwsgi.ini
```
