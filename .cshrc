# eric's .(t)cshrc
# Thu May 20 16:08:45 CDT 1993
#
# this file should work with tcsh or csh

# $Id$	

set path = ( \
  . \
  /usr/local/bin \
  /bin \
  /usr/bin \
  /sbin \
  ~/bin \
  /opt/kde/bin \
  /usr/X11R6/bin \
  /usr/local/Acrobat3/bin \
  /usr/bin/mh \
  /usr/X11R6/bin \
  /usr/bin/mh \
  /usr/sbin \
  /usr/games \
)

if ($?prompt) then			# not a shell script

# limit coredumpsize 0

  if ($?tcsh) then

    set host = `hostname | cut -d. -f1`

    bindkey -k up history-search-backward
    bindkey -k down history-search-forward

    set tperiod = 60

    if ($?WINDOW) then  # we are in screen
      set ppp = "[$WINDOW] "
    else
      set ppp = ""
    endif

    set prompt=": $ppp%S%n@%m%s <%B%l%b> %U%~%u ;\n: [%B%w %D %@%b] %S%?%s %B%h%#%b ; "
    unset ppp

    if ($TERM == "xterm") then
      set host2 = `hostname | awk -F. '{printf "%s.%s", $1, $2}'`
      alias cwdcmd 'echo -n "]2;"/$user@{$HOST}"$cwd]1;"{$host2}""'
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

#   sched 4:00 echo "Go to BED, good grief\!"

  else					# must be csh
    set prompt = "$user@$host \!% "
  endif
# end tcsh

# begin keep these here (not .login)
  set mail = "10 $MAIL"			# modify this and the path
  set history = 500
  set savehist = 500
  set notify filec noclobber
# end keep here not .login

  set cdpath=(~ / ~/in ~/src)

  if ( -r ~/.aliases ) then
    source ~/.aliases
  endif
  if ( -r ~/.env ) then
    source ~/.env
  endif
  if ( -r ~/.typos ) then
    source ~/.typos
  endif
  if ( -r ~/.complete.tcsh ) then
    source ~/.complete.tcsh
  endif

else
  unset history savehist
  # NOTE: Never have noclobber set for shell scripts.
  unset noclobber
endif		# not a shell script
