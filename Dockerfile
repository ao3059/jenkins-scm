# Use the official Node.js image as a base image
FROM node:14

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install app dependencies
RUN npm install

# Copy the rest of application's code
COPY . .

# Expose port the app runs on
EXPOSE 3000

# Define the command to run application
CMD ["npm", "start"]
