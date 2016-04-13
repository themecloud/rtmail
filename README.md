# RTMAIL - An email proxy written in Go

RTMAIL enables you to route incoming SMTP emails to other SMTP destinations and HTTPS endpoints.
See config.example and routes.example on how to configure RTMAIL.

## Usage

`go get -u && go build && chmod +x rtmail`

`./rtmail -config ./config.example`

## Installation

Simply run the following to install a basic setup of RTMAIL.

`curl https://raw.githubusercontent.com/rasmusj-se/rtmail/master/install.sh | bash`

Change your config in /etc/rtmail/ and restart RTMAIL with `service rtmail restart`