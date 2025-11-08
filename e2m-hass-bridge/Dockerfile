ARG BUILD_FROM=ghcr.io/hassio-addons/base:stable
ARG APP_VERSION=latest

FROM nana4rider/e2m-hass-bridge:${APP_VERSION} AS bridge

ARG BUILD_FROM
FROM ${BUILD_FROM}

RUN apk add --no-cache nodejs

WORKDIR /app
COPY --from=bridge /app ./
COPY ./entrypoint.sh /entrypoint.sh

HEALTHCHECK --interval=30s \
    --timeout=3s \
    --start-period=5s \
    CMD curl --fail http://localhost:3000/health || exit 1

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
