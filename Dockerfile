FROM golang:1.17-alpine3.15 AS build_deps

WORKDIR /src

COPY go.mod .
COPY go.sum .
RUN go mod download


FROM build_deps AS build

COPY . .
RUN CGO_ENABLED=0 go build -o webhook -ldflags '-w -extldflags "-static"' .


FROM alpine:3.15

RUN apk add --no-cache ca-certificates
COPY --from=build /src/webhook /usr/local/bin/webhook

ENTRYPOINT ["webhook"]