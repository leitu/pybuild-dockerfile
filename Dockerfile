FROM node:9.4.0-alpine

LABEL maintainer="alex.lei.tu@gmail.com"

CP app /usr/local/

WORKDIR /usr/local/app

# Expose the port
EXPOSE 3978


# Set if you proxy
ENV http_proxy=''
ENV https_proxy=''

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories  &&\
    apk update &&\
    apk add --no-cache make gcc g++ python pulseaudio-dev

ENV http_proxy=''
ENV https_proxy=''

RUN npm update || echo true &&\
    rm -rf node_modules &&\ 
    npm install &&\
    apk del make gcc g++ pulseaudio-dev python

COPY entrypoint.sh /usr/local/bin

CMD ["entrypoint.sh"]
