wsend-gpg
=========

Encrypted end to end file transfer

## Overview

`wsend-gpg` requires `wsend` and `gpg`.  

`wsend-gpg` uses [wsend.net](https://wsend.net) for backend file handling.

## Install

    wget https://raw.github.com/abemassry/wsend-gpg/master/install.sh -O - | bash
    alias wsend="~/.wsend/wsend"
Note: This install command appends the alias to your .bashrc or equivalent

## Or if you're trying to remember it

    wget https://wsend.net/wsend
    chmod +x wsend
    ./wsend file.txt

Your first file is sent and wsend has been installed.

## Features

 - Sending files right from the command line without having to specify a directory
 - Gives you a url
 - Integrates well with unix pipes
 - Send a file without registering
 - User accounts available with large amounts of storage space

## Usage

   **Usage:**
   
     wsend <file>
   
   **Common Commands:**

   *Send a file*

     wsend file.txt

   *Send a file in an email to your friend (if you have the mail command set up)*

     wsend logfile.log | mail -s "Here was that log file you wanted" friend@example.com

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

 1. Q: Why did you program this in Bash wasn't that painful? Bash isn't meant to do these things, you could have used python with pip, nodejs with npm, or ruby with rubygems.
 
  A: While it was painful we wanted this script to be ubiquitous as possible and bash was installed on all of our *nix machines.  We do have plans to write this in the languages you mention and will work towards this in the future.  If you would like to write a client in one of these languages it would be something we would both appreciate and support.

 2. Q: What about wput? Isn't that the opposite of wget?
 
  A: wput is an ftp client and its aim is a little different than that of wsend.  wsend uploads files through https which works on port 443 which in some restricted firewall situations may work (if you can access https pages). They serve different purposes and if you like wput as well as wsend we hope you can use them both, in different ways.

 3. Q: When are the Enthusiast and Hero accounts going to become available?
 
  A: As soon as we generate enough income with the Supporter accounts we can purchase more servers and more space.  We do not want to degrade the quality of paid accounts because paying customers deserve the best treatment.  We do not want to offer services that we can't fully 100% support until we are ready to.

 4. Q: What is the max filesize?

  A: For the Unregistered Account it is 200MB, for the Free account it is 2GB, for the Paid accounts it is 10GB.
 
 5. Q: I had an unregistered 200MB account.  Can I get a listing of my files?
 
  A:  If you register through the command line and then log into https://wsend.net you sould be able to get a listing of all of the files you have uploaded.

 6. Q: But I don't want to register, can't you list my files on the command line with a wsend --ls or some such?
 
  A: While command line account management is definitely in the works, we would really prefer it if you registered so you can make sure a file is actually yours before deleting.

 7. Q: I have an unregistered account, why is my file not loading?

  A: We remove files from unregistered accounts when they become 30 days old or space is needed on the server whichever comes first.

 8. Q: I have a free account, why are my files missing?

  A: We remove files from free accounts when they become 30 days old or space is needed on the server whichever comes first.

 9. Q: But why, that doesn't seem right, no other service does this?

  A: The wsend program and service is primarily provided for sending files. We have to maintain the best service possible for paying users, once the paying user-base grows we can support more benefits for the unregistered and free accounts.  This service is not meant to compete with other services that store files for free, it can be used as a quick and easy way to send files.

 10. Q: Can I use the wsend script to interface with another web service?

  A: By all means, its GPL licensed and you can adapt it to whatever service you would like or create your own.

 11. Q: I have a problem but it is not listed here, who should I ask?

  A: While we will try to respond to all requests, you can contact us at https://wsend.net/about If you are a paying user we will definitely respond and will not rest till your problem is resolved.  Just fill out the contact form with your email that is registered to your paid account.  Paid accounts are so important to us because it not only keeps the lights on and the hard drives spinning, it validates what we are doing and it says you support us, you support the community, and you support an open internet where everyone can exchange ideas.  You are also joining us in contributing to something larger than ourselves.

  

### Help

If you find wsend difficult to use, please open up a [Github issue](https://github.com/abemassry/wsend/issues) or if you see an area that can be improved send a pull request! 

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



#### (C) Copyright 2013, wsend.net
