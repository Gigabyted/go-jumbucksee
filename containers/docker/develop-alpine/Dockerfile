FROM alpine:3.3

RUN \
  apk add --update go git make gcc musl-dev         && \
  git clone https://github.com/jumbucks/go-jumbucksee && \
  (cd go-jumbucksee && git checkout develop)          && \
  (cd go-jumbucksee && make gjbsee)                     && \
  cp go-jumbucksee/build/bin/gjbsee /gjbsee               && \
  apk del go git make gcc musl-dev                  && \
  rm -rf /go-jumbucksee && rm -rf /var/cache/apk/*

EXPOSE 8545
EXPOSE 30303

ENTRYPOINT ["/gjbsee"]
