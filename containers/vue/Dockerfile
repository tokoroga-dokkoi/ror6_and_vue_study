FROM node:12.7.0-alpine

WORKDIR /app

RUN apk update
# Update yarn
RUN npm install -g yarn

# install webpack
RUN yarn global add webpack
RUN yarn add -dev webpack-cli webpack-dev-server
RUN yarn global add @vue/cli
# yarn install
RUN yarn install
# build
COPY . .

# not use docker-compose
EXPOSE 8080
CMD ["/bin/ash"]