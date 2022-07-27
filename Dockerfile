FROM alpine

LABEL maintainer="paul..markus@gmail.com"

RUN apk add --update --no-cache \
  nodejs \
  npm 

COPY . /src

WORKDIR /src

RUN npm install

EXPOSE 8080

RUN npm run build

ENTRYPOINT ["npm", "run", "dev"]



# #
# # ---- Base Node ----
# FROM alpine:3.16 AS base
# # install node
# RUN apk add --no-cache nodejs npm
# # set working directory
# WORKDIR /src
# # # Set npx as as entrypoint
# # ENTRYPOINT ["npx", "serve",  "out"]
# # copy project file
# COPY package.json .
 
# #
# # ---- Dependencies ----
# FROM base AS dependencies
# # install node packages
# RUN npm set progress=false && npm config set depth 0
# RUN npm install --only=production 
# # copy production node_modules aside
# RUN cp -R node_modules prod_node_modules
# # install ALL node_modules, including 'devDependencies'
# RUN npm install
 
# #
# # ---- Test ----
# # run linters, setup and tests
# FROM dependencies AS test
# COPY . .
# RUN  npm run lint && npm run setup && npm run test
 
# #
# # ---- Release ----
# FROM base AS release
# # copy production node_modules
# COPY --from=dependencies /src/prod_node_modules ./node_modules
# # copy app sources
# COPY . .
# # expose port and define CMD
# EXPOSE 8080
# ENTRYPOINT ["npx", "serve", "out"]
