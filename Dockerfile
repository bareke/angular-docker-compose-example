# Define la imagen (model) de Node 10
FROM node:16-alpine as build-step

# Crea la carpeta app
RUN mkdir -p /app

# Establece la ruta a la carpeta app
WORKDIR /app

# Copia el archivo package.json a la carpeta app
COPY package.json /app

# Instala las dependencias contenidas en package.json
RUN npm install

# Copia el resto del proyecto a la carpeta app
COPY . /app

# Ejecuta la aplicación en modo producción
RUN npm run build --prod

# Defina la imagen del servidor (nginx)
FROM nginx:1.17.1-alpine

# Copia los archivos de producción al servidor
COPY --from=build-step /app/dist/angular-example /usr/share/nginx/html

# Expone el puerto del contenedor
EXPOSE 4200
