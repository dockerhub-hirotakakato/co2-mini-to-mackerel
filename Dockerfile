FROM node:lts-alpine AS builder

WORKDIR /co2-mini-to-mackerel

RUN set -eux; \
    apk add --no-cache eudev-dev g++ linux-headers make python3; \
    npm install axios co2-monitor; \
    sed -i 's/\(let decrypted =\)\(.*\)$/\1 process.env.CO2_MONITOR_NO_ENCRYPTION ? data :\2/' node_modules/co2-monitor/co2-monitor.js; \
    wget https://github.com/HirotakaKato/co2-mini-to-mackerel/raw/master/index.js

FROM node:lts-alpine

WORKDIR /co2-mini-to-mackerel

COPY --from=builder /co2-mini-to-mackerel .

RUN apk add --no-cache eudev

CMD ["index.js"]
