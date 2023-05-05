FROM python:3.10-bullseye

RUN set -e \
 && apt-get update \
 && apt-get install -y --no-install-recommends zip unzip \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app
WORKDIR /app

ADD Pipfile Pipfile.lock ./
RUN set -e \
 && pip install pipenv \
 && pipenv install --system --deploy --ignore-pipfile

ADD . ./

ENV PYTHONUNBUFFERED 1
