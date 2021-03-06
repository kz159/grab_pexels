FROM python:3.8.2-alpine3.11 as base

FROM base as builder

WORKDIR /install

RUN apk update && apk add gcc postgresql-dev python3-dev musl-dev git --no-cache

COPY requirements.txt /requirements.txt

RUN pip install --prefix=/install -r /requirements.txt

FROM base

RUN apk add libpq --no-cache

COPY --from=builder /install /usr/local

WORKDIR /app

COPY walld_grab_pexels/ .

CMD python main.py
