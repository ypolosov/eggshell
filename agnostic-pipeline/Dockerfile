FROM node:lts

RUN apt-get update && apt-get install -y \
    apt-utils \
    chromium \
    chromium-driver \
    jq \
    zip

RUN curl -fsSL get.docker.com | sh 

RUN npm install -g npm

# COPY stages stages

WORKDIR /app


