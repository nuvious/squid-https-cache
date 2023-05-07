openssl req -new -newkey rsa:4096 -sha256 -days 365 -nodes -x509 -extensions v3_ca -keyout squid-ca-key.pem -out squid-ca-cert.pem
cat squid-ca-cert.pem squid-ca-key.pem >> squid-ca-cert-key.pem
openssl x509 -in squid-ca-cert.pem -outform DER -out squid-ca-cert.der
