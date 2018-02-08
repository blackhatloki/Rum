!#/bin/bash 
openssl req \
  -x509 -nodes -days 365 -sha256 \
  -newkey rsa:2048 -keyout $1-key.pem -out $1-req.pem
