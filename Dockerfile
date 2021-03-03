FROM node:12.20-alpine

ENV NODE_ENV production
ENV NPM_CONFIG_LOGLEVEL info

# Setup source directory
WORKDIR /app
COPY package*.json ./

# fix vurnerabilities detected by aquascanner
RUN npm i --save lodash@4.17.20
RUN npm i --save y18n@4.0.1

RUN npm ci --production

# Copy app to source directory
COPY . .

RUN rm /app/node_modules/proxy-agent/test/ssl-cert-snakeoil.key

# Change back to the "node" user; using its UID for PodSecurityPolicy "non-root" compatibility
USER 1000
CMD ["npm", "start"]
