FROM ubuntu AS build

RUN apt-get update && apt-get install -y golang-go

ENV GO111MODULE=off

COPY . .

RUN CGO_ENABLED=0 go build -o /app .

ENTRYPOINT ["/app"]

FROM ubuntu
RUN apt-get update -y
RUN apt-get install apache2 -y
COPY . /var/www/html/
EXPOSE 4000
CMD  ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
