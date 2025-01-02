# Use Node.js 16 on Alpine Linux
FROM node:16-alpine

# Set npm configuration to handle timeouts and retries
RUN npm config set fetch-timeout 60000 && npm config set fetch-retries 5

# Optionally, set registry if behind a proxy or using a different registry
# RUN npm config set registry https://registry.npm.taobao.org

# Set working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json first to leverage Docker cache
COPY package*.json ./

# Install dependencies
RUN npm audit fix --force
RUN npm install

# Copy the rest of the application files
COPY . .

# Expose port for the app (adjust based on your app's listening port)
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
