FROM python:3.7

ENV APP_ROOT localhost:8000
ENV WD_ROOT localhost:4444

COPY integration/requirements.txt /srv
COPY features /srv/features

WORKDIR /srv

RUN pip install -r requirements.txt

CMD behave
