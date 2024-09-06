FROM node:lts AS build
RUN git clone https://github.com/FranciscoCasais/ci-cd-casais-esparrach-FRONT.git && \
    cd ci-cd-casais-esparrach-FRONT && \
    git checkout qa && \
    npm install && \
    npm fund && \
    export NG_CLI_ANALYTICS=false && \
    npm run build

FROM nginx:alpine AS run
RUN rm /usr/share/nginx/html/index.html
RUN rm /etc/nginx/conf.d/default.conf
COPY --from=build ci-cd-casais-esparrach-FRONT/dist/ /usr/share/nginx/html/
COPY default.conf /etc/nginx/conf.d/
