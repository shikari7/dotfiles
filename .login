#
#	eric's login file...
#

# $Id$	

#mesg n

if ! { /usr/bin/cmp -s ~/.hushlogin /etc/motd } /usr/bin/tee ~/.hushlogin < /etc/motd

# get lines set right
#eval `/usr/openwin/bin/resize`

if (`tty` == "/dev/console") then
  echo '[q'
endif

# ok, tell me all about it

clear

# Set up the terminal
#eval `tset -s -Q -m ':?hp' `
#stty erase "^H" kill "^U" intr "^C" eof "^D" susp "^Z" hupcl ixon ixoff tostop tabs	
#set term = `qterm +real +usrtab`
#set term = `qterm`

# this is needed as of RedHat 4.1 anyway
if ($?TERM == "dtterm") then
  setenv TERM	vt100
endif

# Set up shell environment:
set noclobber
set history=20

#fetchmail

#trn -c
#msgs -fpq
#echo ""

#screen -ls
messages
#countmail
uptime
