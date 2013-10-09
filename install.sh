#!/bin/bash
#
# Copyright 2013 Abraham Massry
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#
#
bashInstall () {
  als_set=`grep "alias wsend-gpg=" $HOME/.bashrc`
  if [ "$als_set" ]; then
   #do nothing
   true
  else
   echo "alias wsend-gpg='$HOME/.wsend/wsend-gpg'" >> $HOME/.bashrc
   echo "alias wget-gpg='$HOME/.wsend/wget-gpg'" >> $HOME/.bashrc
   echo "alias wsend-gpg='$HOME/.wsend/wsend-gpg'" >> $HOME/.bash_profile
   echo "alias wget-gpg='$HOME/.wsend/wget-gpg'" >> $HOME/.bash_profile
  fi
}
# check to see if directory exists
if [ -d "$HOME/.wsend" ]; then
  wsend_dir="$HOME/.wsend"
else
  # if not, install
  if [ "$freeSpaceK" -gt 100 ]; then
    mkdir $HOME/.wsend
    #download wsend and put it in directory
    wsDL=`curl -o $HOME/.wsend/wsend https://raw.github.com/abemassry/wsend/master/wsend 2>/dev/null`
    chmod +x $HOME/.wsend/wsend
    #supporting files as well
    rmDL=`curl -o $HOME/.wsend/README.md https://raw.github.com/abemassry/wsend/master/README.md 2>/dev/null`
    cpDL=`curl -o $HOME/.wsend/COPYING https://raw.github.com/abemassry/wsend/master/COPYING 2>/dev/null`
    newLatestVersionDL=`curl -o $HOME/.wsend/version https://raw.github.com/abemassry/wsend/master/version 2>/dev/null`
  else
    echoerr "not enough free space to continue. Aborting";
    exit 1;
  fi
  #add alias to shell
  #execute alias command
  if [ $SHELL == "/bin/bash" ]; then
    bashInstall
    echo "enter this to use the wsend command:"
    echo "alias wsend='$HOME/.wsend/wsend'"
  elif [ $SHELL == "/bin/csh" ]; then
    cshInstall
    echo "enter this to use the wsend command:"
    echo "alias wsend '$HOME/.wsend/wsend'"
  elif [ $SHELL == "/bin/tcsh" ]; then
    cshInstall
    echo "enter this to use the wsend command:"
    echo "alias wsend '$HOME/.wsend/wsend'"
  elif [ $SHELL == "/bin/ksh" ]; then
    kshInstall
    echo "enter this to use the wsend command:"
    echo "alias wsend='$HOME/.wsend/wsend'"
  elif [ $SHELL == "/bin/zsh" ]; then
    zshInstall
    echo "enter this to use the wsend command:"
    echo "alias -g wsend='$HOME/.wsend/wsend'"
  fi # install done
fi # check for installation done
echo ''
echo "install done"
