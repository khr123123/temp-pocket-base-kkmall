FROM alpine:latest

ARG PB_VERSION=0.34.2

RUN apk add --no-cache \
    unzip \
    ca-certificates \
    openssh

# download and unzip PocketBase
ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/

# copy migrations
COPY ./pb_migrations /pb/pb_migrations

# copy data
COPY ./pb_data /pb/pb_data

# expose is optional for Back4App (ignored)
EXPOSE 8090

# MUST listen on Back4App dynamic port
CMD ["sh", "-c", "/pb/pocketbase serve --http=0.0.0.0:${PORT}"]
