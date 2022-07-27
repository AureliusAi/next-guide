FROM alpine

LABEL maintainer="paul...markus@gmail.com"

RUN apk add --update --no-cache \
  nodejs \
  npm \
  yarn

COPY . /src

WORKDIR /src

RUN yarn install

EXPOSE 8080

RUN yarn build

ENTRYPOINT ["npx", "serve", "out"]