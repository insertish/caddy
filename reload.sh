#!/bin/sh
docker-compose exec -T caddy /usr/bin/caddy reload --config /etc/caddy/Caddyfile
