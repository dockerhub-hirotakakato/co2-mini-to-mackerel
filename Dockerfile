FROM node:lts-alpine3.12 as build
RUN set -eux; \
    apk add --no-cache eudev-dev g++ linux-headers make python3; \
    mkdir /co2-mini-to-mackerel; \
    cd /co2-mini-to-mackerel; \
    npm install axios co2-monitor; \
    sed -i 's/\(decrypted =\).*$/\1 data;/' node_modules/co2-monitor/co2-monitor.js; \
    wget https://github.com/shimobayashi/co2-mini-to-mackerel/raw/master/index.js

FROM node:lts-alpine3.12
WORKDIR /co2-mini-to-mackerel
CMD ["node", "index.js"]
RUN apk add --no-cache eudev
COPY --from=build /co2-mini-to-mackerel .
