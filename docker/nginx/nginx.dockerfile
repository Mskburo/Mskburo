FROM node:gallium-alpine as build

WORKDIR /app
COPY ../../Frontend/package*.json ./

RUN npm install

COPY ../../Frontend .

RUN npm run build


FROM nginx:latest

COPY --from=build /app/dist /var/app