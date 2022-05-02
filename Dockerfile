# build stage
FROM node:16.13.2-alpine as build
WORKDIR /usr/app
# copy dependencies
COPY package.json ./
COPY yarn.lock ./
RUN yarn install
COPY . .
ENTRYPOINT yarn build
#CMD ["yarn", "start"]

# run stage
FROM nginx:1.21.6-alpine
COPY --from=build /usr/app/build/ /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]


