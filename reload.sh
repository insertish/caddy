#!/bin/sh
docker-compose exec caddy /usr/bin/caddy reload --config /etc/caddy/Caddyfile
