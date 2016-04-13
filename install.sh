curl -s https://build.rtek.se/rtmail > /usr/bin/rtmail
curl -s https://raw.githubusercontent.com/rasmusj-se/rtmail/master/rtmail-service.sh > /usr/bin/rtmail-service.sh
chmod a+x /usr/bin/rtmail
chmod a+x /usr/bin/rtmail-service.sh
curl -s https://raw.githubusercontent.com/rasmusj-se/rtmail/master/upstart.conf > /etc/init/rtmail.conf
mkdir /etc/rtmail/
curl -s https://raw.githubusercontent.com/rasmusj-se/rtmail/master/rtmail.conf > /etc/rtmail/rtmail.conf
curl -s https://raw.githubusercontent.com/rasmusj-se/rtmail/master/routes.conf > /etc/rtmail/routes.conf
openssl req -new -newkey rsa:2048 -subj "/C=US/ST=Oregon/L=Portland/O=Company Name/OU=Org/CN=mail.example.com" -days 365 -nodes -x509 -keyout /etc/rtmail/cert.key -out /etc/rtmail/cert.crt
service rtmail start
echo "Printing start log"
cat /var/log/rtmail.log
echo "Installation finished! Please edit your config in /etc/rtmail/ directory to reflect your settings"