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

## Working with Caddy

There are several scripts available to make your life easier:
- `reload.sh`: apply an updated Caddyfile to the running Caddy server
- `validate.sh`: ensure the provided configuration is valid
- `fmt.sh`: format the provided Caddyfile

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

## Writing Caddyfile

Below are a bunch of useful snippets for common web server configurations which I use really frequently.

You may also want to refer to the [full directives documentation from Caddy](https://caddyserver.com/docs/caddyfile/directives).

### Reverse Proxy

Setting up a reverse proxy takes up a single line:

```Caddyfile
a.test {
  reverse_proxy 127.0.0.1:5000
}
```

You can also do stuff like send headers up to the upstream service along with other configuration, refer to [reverse_proxy](https://caddyserver.com/docs/caddyfile/directives/reverse_proxy).

### Upgrade WebSocket

The following is sufficient to properly handle upgrading WebSockets:

```Caddyfile
@upgrade {
  path /
  header Connection *Upgrade*
  header Upgrade websocket
}

reverse_proxy @upgrade 127.0.0.1:10540
```

### Wildcard Domains

Refer to [tls](https://caddyserver.com/docs/caddyfile/directives/tls) on how to configure specific DNS providers.

```Caddyfile
:80 {
	respond "Hello, World!"
}

*.test {
  tls {
    dns <provider> <token>
  }

	@a host a.test
	handle @a {
		respond "Subdomain a.test"
	}

	@b host b.test
	handle @b {
		respond "Subdomain b.test"
	}

	handle {
		respond "Default handler for *.test"
	}
}
```

### Logging

Below is a sample logger configuration which writes to the data directory.

```Caddyfile
{
  log {
    output file /data/access.log {
      roll_size 1GiB
    }

    format json
    level debug
  }
}
```

Now you can run `tail -f data/access.log` to read from it live.

### Strip Prefix on Route

A common pattern is to handle a route and strip the path prefix, you can combine multiple lines into one as such:

```Caddyfile
handle_path /prefix/* {
  [...]
}
```

When the request is being handled, `/prefix` is ignored, so you can now pass this through to your upstream service for example. See documentation for [handle_path](https://caddyserver.com/docs/caddyfile/directives/handle_path) and [uri for strip_prefix](https://caddyserver.com/docs/caddyfile/directives/uri).
