# Using node:16-alpine base image
FROM node:16-alpine 

# Set /app as the default work directory
WORKDIR /app

# copy package.json to the working directory for packages installation
COPY package.json /app

# Install npm dependencies
RUN npm install

# Copy all the project files to the working directory
COPY . .

# Expose the port of your application to bind with the host port
EXPOSE 3000

# run your app
CMD ["npm", "run", "start"]

# docker build -t rick-morty .  
# sudo docker run -it -p 3000:3000 -d rick-morty  
# Necesitamos los archivos optimizados o estaticos de react para esto ejecutamo npm run biild
# En proximas versiones sera un stage en la creacion de la imagen