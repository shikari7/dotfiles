#
#	eric's login file...
#

# $Id$	

#mesg n

if (-f /etc/motd) then
  if ! { /usr/bin/cmp -s ~/.hushlogin /etc/motd } /usr/bin/tee ~/.hushlogin < /etc/motd
endif

# get lines set right
#eval `/usr/openwin/bin/resize`

if (`tty` == "/dev/console") then
  echo '[q'
endif

# set up terminal
if ($?TERM && $TERM == "dtterm") then
  setenv TERM	vt100
endif

# ok, tell me all about it
clear

# mail and news stuff
#messages
#set t=`perl -e 'print int rand(25) + 1;'`
#( sleep $t; fetchmail >>& /dev/null ) &
#fetchmail >>& /dev/null
#unset t
uptime

# make this test if I'm on Mac
#test -e "${HOME}/.iterm2_shell_integration.tcsh" && source "${HOME}/.iterm2_shell_integration.tcsh" || true

