curl -s https://build.rtek.se/rtmail > /usr/bin/rtmail
chmod a+x /usr/bin/rtmail
curl -s https://raw.githubusercontent.com/rasmusj-se/rtmail/master/upstart.conf > /etc/init/rtmail.conf
mkdir /etc/rtmail/
curl -s https://raw.githubusercontent.com/rasmusj-se/rtmail/master/config.example > /etc/rtmail/rtmail.conf
curl -s https://raw.githubusercontent.com/rasmusj-se/rtmail/master/routes.example > /etc/rtmail/routes.conf
openssl req -new -newkey rsa:2048 -subj "/C=US/ST=Oregon/L=Portland/O=Company Name/OU=Org/CN=mail.example.com" -days 365 -nodes -x509 -keyout /etc/rtmail/cert.key -out /etc/rtmail/cert.crt
service rtmail start