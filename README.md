wsend-gpg
=========

Encrypted end to end file transfer

## Idea
  We wanted to make end to end encryption as simple as possible using standard tools.  wsend-gpg is a very simple 5 line script to get this done.

## Demo

### Encrypt and Send
    user@system:~/Documents$ wsend-gpg message.txt
    Enter passphrase:
      
      % Total    % Received % Xferd Average Speed   Time    Time     Time  Current
                                    Dload  Upload   Total   Spent    Left  Speed
    100   497  100    66  100   431    222   1452 --:--:-- --:--:-- --:--:--  2233
    https://wsend.net/ef9f450907eac00f96d389ae2efb50f6/message.txt.gpg
    user@system:~/Documents$

### Receive and Decrypt
    user@system:~/Documents$ wget-gpg https://wsend.net/ef9f450907eac00f96d389ae2efb50f6/message.txt.gpg
    --2013-10-09 11:59:49--  https://wsend.net/ef9f450907eac00f96d389ae2efb50f6/message.txt.gpg
    Resolving wsend.net (wsend.net)... 66.228.37.175
    Connecting to wsend.net (wsend.net)|66.228.37.175|:443... connected.
    HTTP request sent, awaiting response... 200 OK
    Length: 94 [application/octet-stream]
    Saving to: `message.txt.gpg'

    100%[==============================================>] 94          --.-K/s   in 0.07s

    2013-10-09 11:59:49 (1.41 KB/s) - `message.txt.gpg' saved [94/94]

    gpg: CAST5 encrypted data
    Enter passphrase:
    gpg: encrypted with 1 passphrase
    spider@myst:~/Documents/wsend-gpg$



## Overview

`wsend-gpg` requires `wsend` and `gpg`.  

`wsend-gpg` uses [wsend.net](https://wsend.net) for backend file handling.

## Install

    wget https://raw.github.com/abemassry/wsend-gpg/master/install.sh -O - | bash
    alias wsend="~/.wsend/wsend"; alias wsend-gpg="~/.wsend/wsend-gpg"; alias wget-gpg="~/.wsend/wget-gpg"
Note: This install command appends the alias to your .bashrc or equivalent


## Source
### wsend-gpg
    #!/bin/bash
    #
    gpg -c --force-mdc "$1"
    if [ -e "$1.gpg" ]; then
      $HOME/.wsend/wsend "$1.gpg"
      rm "$1.gpg"
    fi
  
### wget-gpg
    #!/bin/bash
    #
    wget "$1"
    filename=$(echo "$1" | sed 's/\// /g' | awk '{ print $4 }')
    filenamed=$(echo "$filename" | sed 's/.gpg//')
    gpg "$filename"
    if [ -e "$filename" ]; then
      rm "$filename"
    fi

## Features

 - Encrypt file
 - Send file right from the command line without having to specify a directory
 - Gives you a url
 - Integrates well with unix pipes
 - Send a file without registering
 - User accounts available with large amounts of storage space

## Usage

   **Usage:**
   
     wsend-gpg <file>
     wget-gpg <url>
   
   **Common Commands:**

   *Encrypt and Send a file*

     wsend-gpg file.txt

   *Receive a file and Decrypt*

     wget-gpg https://wsend.net/ef9f450907eac00f96d389ae2efb50f6/file.txt.gpg

   *Send a file in an email to your friend (if you have the mail command set up)*

     wsend-gpg logfile.log | mail -s "Here was that log file you wanted" friend@example.com

   *Remember to use a passphrase that your friend already knows (but don't send it over email)*

   *Register*

     wsend --register

   *Login*
   
     wsend --login
   
   *Refer a friend (receive 1GB for you and friend)*
   
     wsend --refer friend@example.com

   *Get a referral link to send to people*
   
     wsend --refer-link
     

## Pricing 

| Account                               | Space     | Price                |
|---------------------------------------|-----------|----------------------|
| Unregistered (Anonymous) Account      | 200MB     | Free                 |
| Free Account                          | 2GB       | Free                 |
| Supporter Paid Account                | 10GB      | $10/year or $1/month |
| Enthusiast Paid Account (coming soon) | ~~75GB~~  | $30/year or $3/month |
| Hero Paid Account (coming soon)       | ~~100GB~~ | $50/year or $5/month |
 

##API
The API is REST like in the sense that there is a representational transfer of state.  It isn't REST like in the sense that the only transport method that is used is HTTP POST.

To get a user id:

    curl -F "start=1" https://wsend.net/createunreg
    
This should be saved to a file or a database

To send a file:

    curl -F "uid=$id" -F "filehandle=@$fileToSend" https://wsend.net/upload_cli
    
Where `$id` is the id from the previous request and `$fileToSend` is the file you would like to send.

To see if the user has storage space available to send this file:

  curl -F "uid=$id" -F "size=$fileToSendSize" https://wsend.net/userspaceavailable
    

Where `$fileToSendSize` is the filesize in bytes.

To register a user:

  curl -F "uid=$id" -F "email=$email" -F "password=$password" https://wsend.net/register_cli
    
You want to protect the password from showing up anywhere as security measure.  For the wsend command line script the password is not echoed and passed directly as a variable.

To log in a user:

  curl -F "email=$email" -F "password=$password" https://wsend.net/login_cli
    

##FAQ

 1. Q: How does this differ from [wsend](https://github.com/abemassry/wsend)
  
  A: `wsend-gpg` uses `wsend` for file transfer to get a url for a file.  [wsend.net](https://wsend.net) is used as a backend file store

 2. Q: How is this different from `scp`?

  A: `scp` is useful for transferring from one system to the other using the ssh protocol.  `wsend-gpg` differs in that both systems don't have to be up and running, the transfer is done using the https protocol, and there are always two steps.

 3. Q: Why did you program this in Bash wasn't that painful? Bash isn't meant to do these things, you could have used python with pip, nodejs with npm, or ruby with rubygems.
 
  A: While it was painful we wanted this script to be ubiquitous as possible and bash was installed on all of our *nix machines.  We do have plans to write this in the languages you mention and will work towards this in the future.  If you would like to write a client in one of these languages it would be something we would both appreciate and support. *Update [node-wsend](https://github.com/abemassry/node-wsend) now available.


 4. Q: When are the Enthusiast and Hero accounts going to become available?
 
  A: As soon as we generate enough income with the Supporter accounts we can purchase more servers and more space.  We do not want to degrade the quality of paid accounts because paying customers deserve the best treatment.  We do not want to offer services that we can't fully 100% support until we are ready to.

 5. Q: What is the max filesize?

  A: For the Unregistered Account it is 200MB, for the Free account it is 2GB, for the Paid accounts it is 10GB. Since wsend-gpg encrypts the file using gpg it might take a long time to encrypt for a large filesize, also the disk is used to store the encrypted file temporarily so make sure you don't run out of space.

 6. Q: I have an unregistered account, why is my file not loading?

  A: We remove files from unregistered accounts when they become 30 days old or space is needed on the server whichever comes first.

 7. Q: I have a free account, why are my files missing?

  A: We remove files from free accounts when they become 30 days old or space is needed on the server whichever comes first.

 8. Q: But why, that doesn't seem right, no other service does this?

  A: The wsend program and service is primarily provided for sending files. We have to maintain the best service possible for paying users, once the paying user-base grows we can support more benefits for the unregistered and free accounts.  This service is not meant to compete with other services that store files for free, it can be used as a quick and easy way to send files.

 9. Q: Can I use the wsend script to interface with another web service?

  A: By all means, its GPL licensed and you can adapt it to whatever service you would like or create your own.

 10. Q: I have a problem but it is not listed here, who should I ask?

  A: While we will try to respond to all requests, you can contact us at https://wsend.net/about If you are a paying user we will definitely respond and will not rest till your problem is resolved.  Just fill out the contact form with your email that is registered to your paid account.  Paid accounts are so important to us because it not only keeps the lights on and the hard drives spinning, it validates what we are doing and it says you support us, you support the community, and you support an open internet where everyone can exchange ideas.  You are also joining us in contributing to something larger than ourselves.

  

### Help

If you find wsend-gpg difficult to use, please open up a [Github issue](https://github.com/abemassry/wsend-gpg/issues) or if you see an area that can be improved send a pull request! 

#### ~.wsend/ directory

In this directory the executable bash script wsend is stored, along with the README.md documentation, the GPL COPYING licence, a file called version which stores the version and which wsend checks against the github repo to determine whether it should install updates, and a file called .id, which is an identifier for the command line user.

#### version

This file stores the version and wsend checks against the github repo to determine whether it should install updates.

#### .id

This file stores an identifier for the command line user

#### README.md

This file

#### COPYING

The GPL licence

#### wsend

The executable bash script, this can send files and also install the ~.wsend/ directory.  The only user file it changes is the .bashrc file by appending the alias to the end.  If you have bash installed but use another popular shell it will install it to that .*rc file

#### wsend-gpg

The `wsend-gpg` executable bash script from this repo.

#### wget-gpg

The `wget-gpg` executable bash script from this repo.


#### (C) Copyright 2013, wsend.net

