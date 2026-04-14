FROM node:20-alpine

RUN apk add --no-cache git

WORKDIR /opt

# Cache buster to guarantee a fresh clone on scheduled builds.
ARG CACHE_BUST=1
RUN echo "CACHE_BUST=${CACHE_BUST}" \
    && git clone --depth 1 https://github.com/mongo-express/mongo-express.git

WORKDIR /opt/mongo-express

RUN npm ci --omit=dev

EXPOSE 8081

CMD ["npm", "start"]
