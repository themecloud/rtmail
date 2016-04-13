curl https://build.rtek.se/rtmail > /usr/bin/rtmail
chmod a+x /usr/bin/rtmail
curl https://raw.githubusercontent.com/rasmusj-se/rtmail/master/upstart.conf > /etc/init/rtmail.conf
mkdir /etc/rtmail/
curl https://raw.githubusercontent.com/rasmusj-se/rtmail/master/config.example > /etc/rtmail/rtmail.conf
curl https://raw.githubusercontent.com/rasmusj-se/rtmail/master/routes.example > /etc/rtmail/routes.conf
openssl req -x509 -newkey rsa:4096 -keyout /etc/rtmail/cert.key -out /etc/rtmail/cert.crt -days 365
service rtmail start