# Definir la imagen base
FROM node:18.18.0-alpine AS base

# Establecer el directorio de trabajo en /app
WORKDIR /app

# Copiar todo el contenido del contexto de construcción al contenedor
COPY . /app

# Instalar las dependencias de desarrollo
RUN yarn install --frozen-lockfile

# Definir una etapa de desarrollo
FROM base AS dev

# Establecer el comando de inicio para desarrollo
CMD ["yarn", "start:dev"]

# Definir una etapa de producción
FROM base AS prod

# Instalar las dependencias de producción
RUN yarn install --frozen-lockfile --production

# Instalar globalmente @nestjs/cli (si es necesario)
RUN yarn global add @nestjs/cli

# Compilar la aplicación
RUN yarn build

# Establecer el comando de inicio para producción
CMD ["yarn", "start:prod"]
