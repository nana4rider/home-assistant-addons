ARG BUILD_FROM=ghcr.io/hassio-addons/base:stable
ARG APP_VERSION=latest

FROM nana4rider/pc2mqtt:${APP_VERSION} AS bridge

ARG BUILD_FROM
FROM ${BUILD_FROM}

RUN apk add --no-cache nodejs

WORKDIR /app
COPY --from=bridge /app ./
COPY ./entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
