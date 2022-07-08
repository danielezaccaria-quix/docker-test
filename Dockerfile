#questo è il dockerfile per la produzione, tutti questi file verranno inseriti in /app/build
FROM node:16-alpine AS builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
#vengono copiati i file dal conteiner precedente e successivamente inseriti dentro la cartella /usr... per essere direttamente processati da nginx
COPY --from=builder /app/build /usr/share/nginx/html