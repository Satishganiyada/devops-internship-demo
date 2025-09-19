FROM node:latest
COPY app/app.js /opt/app.js
CMD ["node", "/opt/app.js"]