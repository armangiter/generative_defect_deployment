#FROM nginx:1.19.0-alpine

#RUN rm /etc/nginx/conf.d/default.conf

#COPY nginx.conf /etc/nginx/conf.d


FROM node:16.17 as admin-build-stage
RUN echo "NODE Version:" && node --version
WORKDIR /usr/local/src/app/admin
COPY rutilea-generative-defects-frontend/package*.json ./
#RUN npm install -g npm@8.5.1
RUN npm config set fetch-retry-maxtimeout 120000
#RUN npm config rm proxy
#RUN npm config rm https-proxy
# RUN npm install @mui/material @emotion/react @emotion/styled --legacy-peer-deps
#RUN npm install webpack webpack-cli --global
#RUN npm install rxjs
#RUN npm  cache clear --force 

RUN npm install --force
COPY data/rutilea_oms_admin_frontend .
RUN npm run dev

# production stage
# FROM nginx:stable-alpine as production-stage
# COPY --from=admin-build-stage /usr/local/src/app/admin /usr/share/nginx/html/admin
# COPY conf.d /etc/nginx/conf.d
EXPOSE 82
# CMD ["nginx", "-g", "daemon off;"]
