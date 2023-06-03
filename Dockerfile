FROM node:lts-alpine

#FROM kobza95/nasa-project:latest

WORKDIR /app

COPY package*.json ./

COPY client/package*.json client/
RUN npm run clean-install-client --omit=dev
COPY server/package*.json server/
RUN npm run clean-install-server --omit=dev

COPY client/ client/
RUN npm run build-docker --prefix client

COPY server/ server/

USER node

CMD [ "npm", "start", "--prefix", "server" ]

EXPOSE 8000