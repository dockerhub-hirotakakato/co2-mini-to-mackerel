FROM node:18-alpine AS builder

WORKDIR /opt/co2-mini-to-mackerel

RUN set -eux; \
    wget https://github.com/HirotakaKato/co2-mini-to-mackerel/raw/master/index.js \
         https://github.com/HirotakaKato/co2-mini-to-mackerel/raw/master/package.json; \
    apk add --no-cache eudev-dev g++ linux-headers make python3; \
    npm install

FROM node:18-alpine

WORKDIR /opt/co2-mini-to-mackerel

COPY --from=builder /opt/co2-mini-to-mackerel .

RUN apk add --no-cache eudev-libs

CMD ["index.js"]
