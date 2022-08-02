FROM alpine:3.15.5

RUN apk update
RUN apk add vim
RUN apk add curl
