FROM golang:alpine AS build-env
RUN apk --no-cache add git
WORKDIR /src
COPY main.go /src/
RUN go get -d ./...
RUN go build main.go 

FROM alpine
# less priviledge user, the id should map the user the downloaded files belongs to
RUN apk --no-cache add curl mtr openssl openldap-clients
RUN apk --no-cache add shadow  && \
        groupadd -r dummy && \
        useradd -r -g dummy dummy -u 1000

WORKDIR /https
COPY --from=build-env /src/main /https/main
EXPOSE 9100/tcp

CMD ["./main"]
