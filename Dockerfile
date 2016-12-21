FROM alpine
MAINTAINER Tito Duarte <duartito@gmail.com>

RUN apk add --update curl bash grep tar sed \
    && rm -rf /var/cache/apk/* \
    && curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-1.12.5.tgz \
    && tar --strip-components=1 -xvzf docker-1.12.5.tgz -C /usr/local/bin \
    && chmod +x /usr/local/bin/docker

ENV GLIBC 2.23-r3
RUN apk update && apk add --no-cache openssl ca-certificates \
    && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.23-r3/glibc-2.23-r3.apk \
    && apk add glibc-2.23-r3.apk \
    && ln -s /lib/libz.so.1 /usr/glibc-compat/lib/ \
    && ln -s /lib/libc.musl-x86_64.so.1 /usr/glibc-compat/lib \
    && curl -L https://github.com/docker/compose/releases/download/1.9.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose


CMD ["bash"]