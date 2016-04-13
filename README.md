# RTMAIL - An email proxy written in Go

RTMAIL enables you to route incoming SMTP emails to other SMTP destinations and HTTPS endpoints.
See config.example and routes.example on how to configure RTMAIL.

## Usage

`go get -u && go build && chmod +x rtmail`

`./rtmail -config ./config.example`