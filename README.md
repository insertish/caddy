# Caddy in Docker

This is my one-stop shop for configuring and running Caddy with Docker including setting up plugins and providing a reference on how to do common configurations.

## Deploy Caddy

Get started by cloning the repository and pulling up the service:

```sh
git clone https://github.com/insertish/caddy
cd caddy
cp Caddyfile.example Caddyfile
docker-compose up -d
```

Caddy will bind to http://localhost:80 and you can now configure it as usual.

## Using Plugins

To start using plugins, copy the example Dockerfile:

```sh
cp Dockerfile.example Dockerfile
```

And configure `docker-compose.override.yml` to build it:

```yml
version: "3"

services:
  caddy:
    build: .
```
