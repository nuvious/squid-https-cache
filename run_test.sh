#!/bin/bash
set -e
docker build -t temp .
docker run -it --rm \
    -v $PWD/squid-ca-cert-key.pem:/etc/squid/certs/squid-ca-cert-key.pem \
    -p 3128:3128 \
    -v $PWD/squid.conf:/etc/squid/squid.conf \
    -v /mnt/ceph/squid-cache:/var/spool/squid/data \
    -v $PWD/whitelist.txt:/etc/squid/whitelist.txt \
    temp

# --entrypoint /bin/bash \
