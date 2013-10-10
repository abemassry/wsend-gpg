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
   echo "alias wsend='$HOME/.wsend/wsend'" >> $HOME/.bashrc
   echo "alias wsend='$HOME/.wsend/wsend'" >> $HOME/.bash_profile
   echo "alias wsend-gpg='$HOME/.wsend/wsend-gpg'" >> $HOME/.bashrc
   echo "alias wget-gpg='$HOME/.wsend/wget-gpg'" >> $HOME/.bashrc
   echo "alias wsend-gpg='$HOME/.wsend/wsend-gpg'" >> $HOME/.bash_profile
   echo "alias wget-gpg='$HOME/.wsend/wget-gpg'" >> $HOME/.bash_profile
  fi
}
cshInstall () {
  als_set=`grep "alias wsend-gpg=" $HOME/.cshrc`
  if [ "$als_set" ]; then
   #do nothing
   true
  else
   echo "alias wsend='$HOME/.wsend/wsend'" >> $HOME/.cshrc
   echo "alias wsend-gpg='$HOME/.wsend/wsend-gpg'" >> $HOME/.cshrc
   echo "alias wget-gpg='$HOME/.wsend/wget-gpg'" >> $HOME/.cshrc
  fi
}
kshInstall () {
  als_set=`grep "alias wsend-gpg=" $HOME/.kshrc`
  if [ "$als_set" ]; then
   #do nothing
   true
  else
   echo "alias wsend='$HOME/.wsend/wsend'" >> $HOME/.kshrc
   echo "alias wsend-gpg='$HOME/.wsend/wsend-gpg'" >> $HOME/.kshrc
   echo "alias wget-gpg='$HOME/.wsend/wget-gpg'" >> $HOME/.kshrc
  fi
}
zshInstall () {
  als_set=`grep "alias wsend-gpg=" $HOME/.zshrc`
  if [ "$als_set" ]; then
   #do nothing
   true
  else
   echo "alias wsend='$HOME/.wsend/wsend'" >> $HOME/.zshrc
   echo "alias wsend-gpg='$HOME/.wsend/wsend-gpg'" >> $HOME/.zshrc
   echo "alias wget-gpg='$HOME/.wsend/wget-gpg'" >> $HOME/.zshrc
  fi
}
# check to see if directory exists
if [ -d "$HOME/.wsend" ]; then
  wsend_dir="$HOME/.wsend"
else
  # if not, install
  mkdir $HOME/.wsend
  #download wsend and put it in directory
  wsDL=`curl -o $HOME/.wsend/wsend https://raw.github.com/abemassry/wsend/master/wsend 2>/dev/null`
  chmod +x $HOME/.wsend/wsend
  newLatestVersionDL=`curl -o $HOME/.wsend/version https://raw.github.com/abemassry/wsend/master/version 2>/dev/null`
  #download wsend-gpg and wget-gpg
  wsgpgDL=`curl -o $HOME/.wsend/wsend-gpg https://raw.github.com/abemassry/wsend-gpg/master/wsend-gpg 2>/dev/null`
  chmod +x $HOME/.wsend/wsend-gpg
  wgpgDL=`curl -o $HOME/.wsend/wget-gpg https://raw.github.com/abemassry/wget-gpg/master/wget-gpg 2>/dev/null`
  chmod +x $HOME/.wsend/wget-gpg
  #add alias to shell
  #execute alias command
  if [ $SHELL == "/bin/bash" ]; then
    bashInstall
  elif [ $SHELL == "/bin/csh" ]; then
    cshInstall
  elif [ $SHELL == "/bin/tcsh" ]; then
    cshInstall
  elif [ $SHELL == "/bin/ksh" ]; then
    kshInstall
  elif [ $SHELL == "/bin/zsh" ]; then
    zshInstall
  fi # install done
fi # check for directory exists done
echo ''
echo "done"
