FROM node:20
LABEL maintainer="Prakash <prakashmanioutbox@gmail.com>"
RUN echo " Try to build my application"
WORKDIR /app
COPY package.json package-lock.json ./
COPY . .
RUN npm install
EXPOSE 3000
ENTRYPOINT ["npm","start"]
