package main

import (
	"bitbucket.org/chrj/smtpd"
	"net/smtp"
	"crypto/tls"
	"errors"
    "strings"
    "log"
    "io/ioutil"
    "flag"
    "encoding/json"
    "regexp"
    "net/http"
    "bytes"
)

type Route struct{
    Recipient string
    Type string
    Destination string
    LocalhostOnly bool
}

type Config struct {
    Cert string
    Key string
    Hostname string
    Relay string
    Username string
    Password string
    Routes string
    Port string
}

func main() {
  
    var configPath string 
    flag.StringVar(&configPath, "config", "/etc/rtmail/rtmail.conf", "RTMAIL config file")
    
    var config Config
    b, err := ioutil.ReadFile(configPath)
    json.Unmarshal(b, &config)
    
    if err != nil{
        panic(err)
    }
    
    var routes []Route
    b, err = ioutil.ReadFile(config.Routes)
    json.Unmarshal(b, &routes)
    
    if err != nil{
        panic(err)
    }
    
    for _, route := range routes{
        log.Println("Handling", route.Recipient)
    }
    
    flag.Parse()
    
    log.Println("Mailserver is starting...")
    
    log.Println("Relay is",strings.Split(config.Relay, ":")[0])

	cert, err := tls.LoadX509KeyPair(config.Cert, config.Key)

	if err != nil {
		panic(err)
	}
    
    log.Println("Certificates loaded...")
        
	server := &smtpd.Server{

		Hostname: config.Hostname,

	    Handler: func(peer smtpd.Peer, env smtpd.Envelope) error {
            for _, route := range routes{
                if !(route.LocalhostOnly && peer.Addr.String() != "127.0.0.1"){
                    for _, recipient := range env.Recipients{
                        match, _ := regexp.MatchString(route.Recipient, recipient)
                        if (match || route.Recipient == ""){
                            log.Println("Email received and forwared for " + recipient)
                            
                            var dst []string
                            if route.Destination != ""{
                                dst = []string{route.Destination}
                            }else{
                                dst = env.Recipients
                            }
                            if route.Type == "SMTP"{
				if config.Username != ""{
                                return smtp.SendMail(
                                            config.Relay,
                                            smtp.PlainAuth(config.Username, config.Username, config.Password, strings.Split(config.Relay, ":")[0]),
                                            env.Sender,
                                            dst,
                                            env.Data,
                                )
				}else{
				return smtp.SendMail(
                                            config.Relay,
                                            nil,
                                            env.Sender,
                                            dst,
                                            env.Data,
                                )
				}
                            }
                            if route.Type == "HTTP"{     
                                data, err := json.Marshal(env)
                                if (err != nil){
                                    log.Println("Unable to parse envelope from", env.Sender)
                                }else{
                                    http.Post(route.Destination, "application/json", bytes.NewBuffer(data))
                                    return nil
                                }
                            }
                        }else{
                            log.Println("Email rejected for " + recipient)
                        }
                    }
                }
            }
            
            return errors.New("Invalid Recipient. This server does not handle the recipient.")

	    },

	    RecipientChecker:  func(peer smtpd.Peer, addr string) error {
            return nil
	    },

	    TLSConfig: &tls.Config{
			Certificates: []tls.Certificate{cert},
		},

		ForceTLS: true,

	}
    
    log.Println("Mailserver is listening.")

	err = server.ListenAndServe(":" + config.Port)
	if err != nil {
		log.Fatal(err)
	}
    
    log.Println("Mailserver exiting peacefully.")
}
