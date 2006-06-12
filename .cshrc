# eric's .(t)cshrc
# Thu May 20 16:08:45 CDT 1993
#
# this file should work with tcsh or csh

# $Id$	

set path = ( \
  . \
  /bin \
  /usr/bin \
  /sbin \
  ~/bin \
  /opt/kde/bin \
  /usr/X11R6/bin \
  /usr/bin/mh \
  /usr/X11R6/bin \
  /opt/X11/bin \
  /usr/bin/mh \
  /usr/sbin \
  /usr/ccs/bin \
  /usr/ucb \
  /usr/games \
  /usr/local/bin \
  /usr/local/BerkeleyDB.4.1/bin \
  /usr/local/BitTorrent-3.3 \
)

if ($?prompt) then		# not a shell script

limit coredumpsize unlimited

  if ($?tcsh) then

    bindkey -k up history-search-backward
    bindkey -k down history-search-forward

    set tperiod = 60

    set red = "%{\033[31m%}"
    set blue = "%{\033[34m%}"
    set green = "%{\033[32m%}"
    set lblue = "%{\033[36m%}"
    set white = "%{\033[0m%}"

    if ($?WINDOW) then  # we are in screen
      set ppp = " [$WINDOW] "
    else
      set ppp = " "
    endif

    set prompt=":$ppp%S%n@%m%s (%B%l%b) %U%~%u ;\n: [%B%w %D %@%b] %S%?%s %B%h%#%b ; "
#   set prompt=":$ppp$red%n@%m ($green%l) %U$lblue%~%u ;\n: [$lblue%w %D %@] %S$red%?%s $lblue%h%# $blue; "
    unset ppp

    if ($?TERM && ($TERM == "xterm" || $TERM == "screen" || $TERM == "rxvt")) then
      alias cwdcmd 'echo -n "]2;"/$user@{$HOST}"$cwd]1;"{$HOST}""'
      cwdcmd
    endif

    set prompt2="%R loop: "
    set prompt3="oops\041 %R (y|n|e)? "

    set autoexpand autolist chase_symlinks
    set correct = cmd
#   set fignore = (.aux .cp .dvi .elc .fn .log .o .orig .pg .toc .tp .vr)
    set listjobs = long
    set promptchars = "%#"
#   set watch = (5 any console edh any root any)
    set who="%B%n%b	has %a %B%l%b	at %B%T%b from %B%m%b"

    unset autologout ignoreeof
    unset red blue green lblue white

#   sched 4:00 echo "Go to BED, good grief\!"

  else				# must be csh
    set prompt = "$user@$HOST \!% "
  endif				# end tcsh

# begin keep these here (not .login)
  if ($?MAIL) then
    set mail = "10 $MAIL"	# modify this and the path
  endif
  set history = (500 '%h\t%P\t%R\n')
  set savehist = (500 merge)
  set notify filec noclobber
# end keep here (not .login)

  set cdpath=(~ / ~/in ~/src)

  if ( -r ~/.aliases ) then
    source ~/.aliases
  endif
  if ( -r ~/.env ) then
    source ~/.env
    if ($?ORACLE_HOME) then
      set path = ( $path $ORACLE_HOME )
    endif
  endif
  if ( -r ~/.typos ) then
    source ~/.typos
  endif
  set completetcsh = `locate complete.tcsh | grep /usr/share/doc | head -1`
  if ( -r "$completetcsh" ) then
    source "$completetcsh"
  endif
  unset completetcsh

else
  unset history savehist
  # NOTE: Never have noclobber set for shell scripts.
  unset noclobber
endif				# not a shell script
