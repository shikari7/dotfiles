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

# set up terminal
#if ($?TERM && $TERM == "dtterm") then
#  setenv TERM	vt100
#endif

# mail and news stuff
#fetchmail
#trn -c
#msgs -fpq
#echo ""
#countmail
messages
uptime

#screen -ls
