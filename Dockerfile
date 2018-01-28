FROM alpine:3.7 as builder

RUN apk add --no-cache autoconf \
    automake \
    build-base \
    curl \
    curl-dev \
    git \
    openssl-dev

RUN git clone https://github.com/BitzenyCoreDevelopers/cpuminer.git

WORKDIR cpuminer

RUN ./autogen.sh && \
    ./configure CFLAGS="-O3" && \
    make

FROM alpine:3.7

RUN apk add --no-cache curl \
    curl-dev

COPY --from=builder /cpuminer/minerd /minerd

ENTRYPOINT ["./minerd"]