tail -F /var/log/squid/access.log &
tail -F /var/log/squid/error.log &
tail -F /var/log/squid/store.log &
tail -F /var/log/squid/cache.log &

# In the event the cache is on an NFS, CephFS, etc, ensure permissions are correct
chown -R proxy:proxy /var/spool/squid/data

/usr/sbin/squid -Nz
/usr/sbin/squid "$@"
