FROM node:latest
WORKDIR /app
COPY app/* /app/
RUN npm install

CMD ["node", "app.js"]

