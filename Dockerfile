# FROM node:20
# LABEL maintainer="Prakash <prakashmanioutbox@gmail.com>"
# RUN echo " Try to build my application"
# WORKDIR /app
# COPY package.json package-lock.json ./
# COPY . .
# RUN npm install
# EXPOSE 3000
# ENTRYPOINT ["npm","start"]

# Use an official Node.js runtime as a parent image
FROM node:20 AS build

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install Angular CLI globally
RUN npm install -g @angular/cli

# Install dependencies
RUN npm install

# Copy the remaining application code to the working directory
COPY . .

# Build the Angular app for production
RUN ng build

# Use Nginx as the base image for serving content
FROM nginx:alpine

# Copy the built Angular app from the previous stage to the NGINX HTML directory
COPY --from=build /usr/src/app/dist/ /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start NGINX server when the container starts
CMD ["nginx", "-g", "daemon off;"]

