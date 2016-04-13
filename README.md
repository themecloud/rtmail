# RTMAIL - An email proxy written in Go

RTMAIL enables you to route incoming SMTP emails to other SMTP destinations and HTTPS endpoints.
See config.example and routes.example on how to configure RTMAIL.

## Usage

Set your email routes in a separate file (see example) and add the path to your routes file in the main config file.
You can set the TLS certificate and key aswell as what SMTP relay to use in the main config file. 

## Installation

Simply run the following to install a basic setup of RTMAIL.

`curl -s https://raw.githubusercontent.com/rasmusj-se/rtmail/master/install.sh | sudo bash`

Change your config in /etc/rtmail/ and restart RTMAIL with `service rtmail restart`

## From source

`go get -u && go build && chmod +x rtmail`

`./rtmail -config ./config.example`