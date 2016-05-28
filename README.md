# [`nginx_ssl_compose`](this.project_github_url)

GitHub/BitBucket/GitLab Pages with your own SSL certificates.

Serve static files fast with, [nginx](nginx), HTTPS & multiple hosts.

Take a look at the Makefile (it's short).

``` shell
$ make pull
$ make 'up -d'  # Awkwardly passes arguments to docker-compose
$ make logs
$ make 'stop pages'
```

## Why

Note: Diffie-Hellman parameters generation takes multiple minutes on startup (don't panic).

* Uses `docker-compose` (`≥ 1.6`)
* Uses the official docker image of `nginx` by default
* Highly re-configurable
* `HTTPS`
  - HTTP redirects to HTTPS automatically
  - Uses one multi-domain SSL cert. [Make your own](#create-your-ssl-certificates)
* [Hardened TLS](https://github.com/BetterCrypto/Applied-Crypto-Hardening/blob/master/src/configuration/Webservers/nginx/default-hsts) configuration.
* Generates unique Diffie-Hellman parameters to mitigate precomputation based attacks on common parameters. Refs: [Guide to Deploying Diffie-Hellman for TLS](https://weakdh.org/sysadmin.html).
* Local caching enabled by default (APCu).
* IPv6 & IPv4 enabled
* Files are gzip-ed on the fly
* If a site appears to use Jekyll it will be built before served


## Create your SSL certificates

There's `make-ssl-cert generate-default-snakeoil`.

I recommend Let's Encrypt:

``` shell
$ git clone https://github.com/letsencrypt/letsencrypt letsencrypt.git
$ cd letsencrypt.git
$ sudo -H ./letsencrypt-auto -v  # Updates packages, installs things, for fresh LE clones only
$ ./letsencrypt-auto certonly --standalone --email ${your_email} -d ${name1} -d ${name2}
$ letsencrypt-auto renew  # Run this every week: LE's certs expire after 90 days
```

* `${your_email}`: MUST be present, will be used to contact you for security issues (e.g.: `pierrefenoll@gmail.com`
* `${name1}`, `${name2}`: As many domains you need. LE does not support wildcard sub-TLDs. (e.g.: `dev.erldocs.com`)

Now, LE has created PEMs under `${name1}`:

``` shell
$ sudo ls /etc/letsencrypt/live/dev.erldocs.com
cert.pem  chain.pem  fullchain.pem  privkey.pem
```


## License

This is inspired from https://github.com/jchaney/owncloud

This project is distributed under [MIT License][LICENSE].

[nginx]: https://en.wikipedia.org/wiki/Nginx
[LICENSE]: https://github.com/fenollp/nginx_ssl_compose/blob/master/LICENSE
[this.project_github_url]: https://github.com/fenollp/nginx_ssl_compose
