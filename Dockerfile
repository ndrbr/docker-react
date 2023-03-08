FROM node:16-alpine as builder

WORKDIR '/app'

COPY package.json .
RUN mkdir -p /app/node_modules
RUN chown node:node /app/node_modules
RUN npm install

COPY . .

RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
