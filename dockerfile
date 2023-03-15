FROM node:12.22.6-alpine As build
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build



FROM nginx:1.23.3-alpine-slim AS stage
COPY --from=build /app/dist/angular-docker /usr/share/nginx/html
EXPOSE 80
CMD ["nginx","-g","daemon off;"]
