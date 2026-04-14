FROM node:20-alpine

RUN apk add --no-cache git

WORKDIR /opt

# Cache buster to guarantee a fresh clone on scheduled builds.
ARG CACHE_BUST=1
RUN echo "CACHE_BUST=${CACHE_BUST}" \
    && git clone --depth 1 https://github.com/mongo-express/mongo-express.git

WORKDIR /opt/mongo-express

# Upstream does not always ship a lockfile on every branch/state, so support both paths.
RUN if [ -f package-lock.json ] || [ -f npm-shrinkwrap.json ]; then \
      npm ci --omit=dev; \
    else \
      npm install --omit=dev; \
    fi

EXPOSE 8081

CMD ["npm", "start"]
