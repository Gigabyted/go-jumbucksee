FROM alpine:3.3

RUN \
  apk add --update go git make gcc musl-dev         && \
  git clone https://github.com/jumbucks/go-jumbucksee && \
  (cd go-ethereum && git checkout develop)          && \
  (cd go-ethereum && make gjbsee)                     && \
  cp go-ethereum/build/bin/gjbsee /gjbsee               && \
  apk del go git make gcc musl-dev                  && \
  rm -rf /go-ethereum && rm -rf /var/cache/apk/*

EXPOSE 8545
EXPOSE 30303

ENTRYPOINT ["/gjbsee"]
