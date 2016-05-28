.PHONY: test

# Set default env variables as docker-compose.yml does not support that (yet?)

## Just drop your Pages folders in this path
##   E.g:  $docker_static_pages_root/dev.erldocs.com
##         $docker_static_pages_root/erldocs.com
##         $docker_static_pages_root/other.erldocs.com
export docker_static_pages_root ?= ~/wefwefwef/docs/sites

export docker_http_port  ?= 80
export docker_https_port ?= 443

## Paths to your Let's Encrypt SSL certificate
cert_name=dev.erldocs.com
export docker_ssl_cert ?= /etc/letsencrypt/live/$(cert_name)/fullchain.pem
export docker_ssl_key  ?= /etc/letsencrypt/live/$(cert_name)/privkey.pem
## The generated DH parameter
export docker_ssl_dh   ?= ./param.pem

## Use latest stable nginx (safest)
export nginx_image ?= nginx:stable


param.pem:
	openssl dhparam -out $@ 4096

test:
	docker-compose config --quiet

%:
	docker-compose $@
