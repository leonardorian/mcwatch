FROM golang:1.18-alpine as builder

ENV GOPATH /go
ENV CGO_ENABLED 0
ENV GO111MODULE on

RUN  \
     apk add --no-cache git && \
     git clone https://github.com/minio/mc && cd mc && \
     go install -v -ldflags "$(go run buildscripts/gen-ldflags.go)"


FROM debian:stable
RUN apt-get update && apt-get install -y ca-certificates
COPY --from=builder /go/bin/mc /usr/bin/mc
COPY entrypoint.sh .
RUN chmod a+x entrypoint.sh

ENV SOURCE_ENDPOINT source
ENV SOURCE_USER source
ENV SOURCE_PASSWORD source
ENV SOURCE_BUCKET source

ENV TARGET_ENDPOINT source
ENV TARGET_USER source
ENV TARGET_PASSWORD source
ENV TARGET_BUCKET source

ENTRYPOINT ["./entrypoint.sh"]
