FROM node:20.6.1 AS node
FROM ruby:3.0.1
RUN apt-get update -qq
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
&& apt-get install -y nodejs

WORKDIR /conkt-v2

COPY Gemfile Gemfile.lock /conkt-v2/

RUN bundle config set --global force_ruby_platform true
RUN bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

COPY --from=node /usr/local/bin/node /usr/local/bin/node
COPY --from=node /usr/local/include/node /usr/local/include/node
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
RUN ln -s /usr/local/bin/node /usr/local/bin/nodejs && \
    ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm
COPY package.json yarn.lock ./

RUN npm install --global yarn
RUN yarn install
ENV NODE_OPTIONS=--openssl-legacy-provider

COPY . ./

CMD ["rails", "server", "-b", "0.0.0.0"]
