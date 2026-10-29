FROM node:lts-alpine

RUN apk add --no-cache git \
    && npm install --global corepack \
    && corepack enable

WORKDIR /opt

# Cache buster to guarantee a fresh clone on scheduled builds.
ARG CACHE_BUST=1
RUN echo "CACHE_BUST=${CACHE_BUST}" \
    && git clone --depth 1 https://github.com/mongo-express/mongo-express.git

WORKDIR /opt/mongo-express

# Use upstream's pinned Yarn release and lockfile, including its resolutions.
# Test-only binaries are not needed to build the production assets.
RUN CYPRESS_INSTALL_BINARY=0 MONGOMS_DISABLE_POSTINSTALL=1 yarn install --immutable \
    && yarn build \
    && yarn workspaces focus --production

ENV VCAP_APP_HOST=0.0.0.0

EXPOSE 8081

CMD ["npm", "start"]
