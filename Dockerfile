FROM node:lts-alpine AS build
WORKDIR /app
COPY yarn.lock package.json ./
RUN yarn install --frozen-lockfile
COPY . .
RUN yarn build

FROM nginx:stable-alpine AS dist
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
