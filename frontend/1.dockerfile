## Build
# docker build -t full-front:0.1.1 .

## Run
# docker run -p 3000:3000 -d full-front:0.1.1

## Entrar al contenedor
# docker run -it full-front:0.1.0 /bin/bash

FROM node:18.9.0 as compilacion

COPY . /opt/app

WORKDIR /opt/app

ENV REACT_APP_BACKEND_BASE_URL=http://localhost:8500

RUN npm install

RUN npm run build

FROM node:18.9.0

COPY --from=compilacion /opt/app/build /opt/app/build

WORKDIR /opt/app

RUN npm install -g serve

CMD ["serve", "-s", "build"]
