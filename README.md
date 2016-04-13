# RTMAIL - An email proxy written in Go

RTMAIL enables you to route incoming SMTP emails to other SMTP destinations and HTTPS endpoints.
See rtmail.conf and routes.conf on how to configure RTMAIL.

## Usage

Set your email routes in a separate file (see example) and add the path to your routes file in the main config file.
You can set the TLS certificate and key aswell as what SMTP relay to use in the main config file. 

## Installation

Simply run the following to install a basic setup of RTMAIL.

`curl -s https://raw.githubusercontent.com/rasmusj-se/rtmail/master/install.sh | sudo bash`

Change your config in /etc/rtmail/ and start RTMAIL with `rtmail`

## From source

`go get -u && go build && chmod +x rtmail`

`./rtmail -config ./config.example`

## Configuring as a linux service in Ubuntu Server

Put the following in `/etc/init/rtmail.conf`

```
# rtmail.conf
start on filesystem
console log
exec /usr/bin/rtmail
respawn
respawn limit 10 90
```

Then you can use `service rtmail start` to start the RTMAIL service.

## Routes

In can configure your email routes in routes.conf, a route looks like this:
```
    {
        "Recipient":".+@example.com",
        "Type":"SMTP",
        "Destination":"me@example.se",
        "LocalhostOnly": false
    }
```
Where recipient is a regex string of which incoming mail will have to match to activate the route. Type is the forwarding type, may be ither HTTP or SMTP. Destination is where to send the mail, if this is blank the destination address will not be changed. If you are using HTTP routing Destination should be set to an URL of which to POST your raw email data.

To create a local forwarding server (local open relay) you can add the following to the routes.
```
    {
        "Type":"SMTP",
        "LocalhostOnly": true
    }
```
This will match all recipients and will not change the recipient when routing. It is also only permitted from localhost to protect us from creating an open-replay that spam-bots can use.

## Config

```
{
    "Cert":"/etc/rtmail/cert.crt",
    "Key":"/etc/rtmail/cert.key",
    "Hostname":"mail.example.com",
    "Relay":"smtp.sendgrid.net:587",
    "Username":"username",
    "Password":"password",
    "Routes":"/etc/rtmail/routes.conf",
    "Port":"25"
}
```
This is the standard configuration. Cert and Key specifies which TLS certficate and key to use on the incoming SMTP server. Relay is the SMTP server that we will send our mail to when we use SMTP routing, username and password is the auth that will be used on the relay server. Routes is the path to the routing file.

## Why

I created this to forward mails to my private email rasmus@rasmusj.se to my gmail inbox, and I thought that I might want to add more routes in the future so I added a general feature to add more routes to the relay without having to recompile the binary. 
