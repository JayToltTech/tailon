FROM golang:alpine as build

WORKDIR /tailon

ADD . .

RUN apk add --upgrade binutils

RUN cd /tailon && \
    go get && \ 
    go build && \
    strip tailon

RUN apk del binutils

FROM alpine:latest

RUN apk add gawk grep sed

COPY --from=build /tailon/tailon /tailon/tailon

CMD        ["--help"]
WORKDIR /tailon
ENTRYPOINT ["./tailon"]
EXPOSE 8080
