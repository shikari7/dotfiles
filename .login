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

# set up terminal
if ($?TERM && $TERM == "dtterm") then
  setenv TERM	vt100
endif

set t=`perl -e 'print int rand(10) + 1;'`
( sleep $t; sigsetup --pipe; fetchmail >>& /dev/null ) &
unset t

# ok, tell me all about it
clear

# mail and news stuff
messages
uptime
