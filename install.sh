curl https://build.rtek.se/rtmail > /usr/bin/rtmail
chmod a+x /usr/bin/rtmail
curl https://build.rtek.se/rtmail.conf > /etc/init/rtmail.conf
mkdir /etc/rtmail/
curl https://build.rtek.se/rtmail.server.conf > /etc/rtmail/rtmail.conf
curl https://build.rtek.se/rtmail.routes.conf > /etc/rtmail/routes.conf
openssl req -x509 -newkey rsa:4096 -keyout /etc/rtmail/cert.key -out /etc/rtmail/cert.crt -days 365
service rtmail start