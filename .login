#
#	eric's login file...
#

mesg n

if ! { /usr/bin/cmp -s ~/.hushlogin /etc/motd } /usr/bin/tee ~/.hushlogin < /etc/motd

# get lines set right
#eval `/usr/openwin/bin/resize`

if (`tty` == "/dev/console") then
  echo '[q'
endif

# ok, tell me all about it

clear

#set term = `qterm +real +usrtab`
#set term = `qterm`

#fetchmail

#trn -c
#msgs -fpq
#echo ""

screen -ls
#messages
countmail
uptime
