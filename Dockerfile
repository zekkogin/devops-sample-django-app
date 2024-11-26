# Базовый образ: python:3.8-slim
FROM python@sha256:1d52838af602b4b5a831beb13a0e4d073280665ea7be7f69ce2382f29c5a613f as builder

WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends libssl-dev build-essential postgresql-client && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /app/wheels -r requirements.txt


FROM python@sha256:1d52838af602b4b5a831beb13a0e4d073280665ea7be7f69ce2382f29c5a613f

WORKDIR /app

COPY --from=builder /app/wheels /wheels
COPY --from=builder /app/requirements.txt .

RUN apt-get update && \
    apt-get install -y --no-install-recommends postgresql-client && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache /wheels/*

CMD ["sh", "-c", "until pg_isready -h $DJANGO_DB_HOST -d $DJANGO_DB_NAME -p $DJANGO_DB_PORT; do echo 'Waiting for database'; sleep 1; done && python3 manage.py migrate && uwsgi uwsgi.ini"]



