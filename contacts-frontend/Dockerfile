FROM alpine as builder
RUN apk add --update nodejs npm
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .

FROM nginx
EXPOSE 4200
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
