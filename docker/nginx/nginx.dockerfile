FROM node:gallium-alpine as build-client

WORKDIR /app
COPY ../../Frontend/package*.json ./

RUN npm install

COPY ../../Frontend .

RUN npm run build

FROM node:gallium-alpine as build-admin

WORKDIR /app
COPY ../../admin/package*.json ./

RUN npm install

COPY ../../admin .

RUN npm run build

FROM nginx:latest

COPY --from=build-client /app/dist /var/app/vue-client
COPY --from=build-admin /app/dist /var/app/vue-admin