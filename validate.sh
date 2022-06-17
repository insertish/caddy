#!/bin/sh
docker-compose exec caddy caddy validate --config /etc/caddy/Caddyfile
