# Stage 1: Build the React app
FROM node:14 as build

WORKDIR /app
COPY package*.json ./

# Install dependencies
RUN npm install

COPY . .
RUN npm run build

FROM nginx:alpine

# Copy the built app from the previous stage to the Nginx directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 for serving the app
EXPOSE 80

# Start Nginx to serve the app
CMD ["nginx", "-g", "daemon off;"]
