FROM python:3.7

EXPOSE 8080

COPY srv /srv
COPY www /srv/site

WORKDIR /srv/site

CMD python3 -m http.server 8080
