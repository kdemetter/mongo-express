FROM node:lts-alpine

RUN apk add --no-cache git

WORKDIR /opt

# Cache buster to guarantee a fresh clone on scheduled builds.
ARG CACHE_BUST=1
RUN echo "CACHE_BUST=${CACHE_BUST}" \
    && git clone --depth 1 https://github.com/mongo-express/mongo-express.git

WORKDIR /opt/mongo-express

# Upstream build scripts execute during install and require dev dependencies.
# Install all deps first, then prune to production-only runtime deps.
RUN if [ -f package-lock.json ] || [ -f npm-shrinkwrap.json ]; then \
      npm ci --include=dev; \
    else \
      npm install --include=dev; \
    fi \
    && npm prune --omit=dev

ENV VCAP_APP_HOST=0.0.0.0

EXPOSE 8081

CMD ["npm", "start"]
