### STAGE 1: Build ###
FROM node:16.10-alpine AS build
RUN /usr/sbin/groupadd -r gemapp && useradd --no-log-init -r -g gemapp gemapp
WORKDIR /usr/src/app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build

### STAGE 2: Run ###
FROM nginx:1.17.1-alpine
# RUN groupadd -r gemapp && useradd --no-log-init -r -g gemapp gemapp
# CMD chown -R gemapp:gemapp /var/cache/nginx && chown -R gemapp:gemapp /etc/nginx && chown -R gemapp:gemapp /usr/share/nginx
USER gemapp
COPY --from=build /usr/src/app/dist/webfingo /usr/share/nginx/html
