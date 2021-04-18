FROM node:lts-alpine3.13 as node

# node modules
COPY yarn.lock ${ROOT}
COPY package.json ${ROOT}
RUN yarn install

FROM ruby:2.7.2-alpine3.13 as builder

ENV ROOT="/app"
ENV LANG=C.UTF-8
ENV TZ=Asia/Tokyo
WORKDIR ${ROOT}

RUN apk update && \
    apk add --no-cache \
        gcc \
        git \
        g++ \
        libc-dev \
        libxml2-dev \
        linux-headers \
        make \
        openssh \
        postgresql-dev \
        tzdata && \
    apk add --virtual build-packs --no-cache \
        build-base \
        curl-dev

# gem
COPY Gemfile ${ROOT}
COPY Gemfile.lock ${ROOT}

RUN bundle install

FROM ruby:2.7.2-alpine3.13 as dev

ENV ROOT="/app"
ENV LANG=C.UTF-8
ENV TZ=Asia/Tokyo
ENV RAILS_ENV=development
WORKDIR ${ROOT}

RUN apk update && \
    apk add --no-cache\
        nodejs \
        postgresql-dev \
        tzdata \
        yarn

COPY --from=node /node_modules ${ROOT}/node_modules
COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY . ${ROOT}
COPY entrypoint.sh /usr/bin/

RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
