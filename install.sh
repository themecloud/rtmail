curl -s https://build.rtek.se/rtmail > /usr/bin/rtmail
chmod a+x /usr/bin/rtmail
curl -s https://raw.githubusercontent.com/rasmusj-se/rtmail/master/upstart.config > /etc/init.d/rtmail
chmod 755 /etc/init.d/rtmail
chown root:root /etc/init.d/rtmail
mkdir /etc/rtmail/
curl -s https://raw.githubusercontent.com/rasmusj-se/rtmail/master/config.example > /etc/rtmail/rtmail.conf
curl -s https://raw.githubusercontent.com/rasmusj-se/rtmail/master/routes.example > /etc/rtmail/routes.conf
openssl req -new -newkey rsa:2048 -subj "/C=US/ST=Oregon/L=Portland/O=Company Name/OU=Org/CN=mail.example.com" -days 365 -nodes -x509 -keyout /etc/rtmail/cert.key -out /etc/rtmail/cert.crt
useradd -r -s /bin/false rtmail
setcap CAP_NET_BIND_SERVICE=+eip /usr/bin/rtmail
chown -R rtmail:rtmail /etc/rtmail
update-rc.d rtmail defaults
update-rc.d rtmail enable
service rtmail start