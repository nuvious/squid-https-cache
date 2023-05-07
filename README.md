# Squid HTTPS Proxy

A quick recipe for making a squid https proxy for all or specific domains.

## Quick Start

### Generate Certs

Generate certificates using the provided helper script; you may want to modify
it to your liking with respect to openssl parameters.

```bash
/bin/bash generate-certs.sh
# Follow prompts
```

Now you need to import the `squid-ca-cert.der` into your trusted root
certificate authority cache for your OS.

### Create Configuration

Copy one of the template configuration files to `squid.conf` in the root of the
directory.

 - `squid-all.conf` - ssl_bumps all traffic
 - `squid-bump-select.conf` - ssl_bumps traffic as specified by cachelist.txt and splices the rest
 - `squid-splice-select.conf` - ssl_bumps all traffic except domains specified by splicelist.txt

 After selecting a configuration to work with, modify the appropriate domain list and consider editing the cache directory and max object size limits.


 ### Launch With Docker

 ```bash
#!/bin/bash
docker build -t squid-cache-https .
docker run -it --rm \
    -v $PWD/squid-ca-cert-key.pem:/etc/squid/certs/squid-ca-cert-key.pem \
    -p 3128:3128 \
    -v $PWD/squid.conf:/etc/squid/squid.conf \
    -v /PATH/TO/CACHE/DIR:/var/spool/squid/data \
    -v $PWD/cachelist.txt:/etc/squid/cachelist.txt \
    -v $PWD/splicelist.txt:/etc/squid/splicelist.txt \
    squid-cache-https
 ```

 ### Launch With Docker-Compose

 Modify the `PATH_TO_CACHE_STORAGE` placeholder in the docker-compose.yml. Then launch:

 ```bash
docker-compose up -d
```