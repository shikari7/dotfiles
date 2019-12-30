# eric's .bashrc
# Mon Apr  8 14:50:20 CDT 2002
# $Id: .cshrc,v 1.15 2001/08/22 00:45:03 edh Exp edh $	

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# set prompt

# see http://www.linuxselfhelp.com/howtos/Bash-Prompt/Bash-Prompt-HOWTO-6.html
#PS1="\[\033]0;\u@\h:\w\007\]: \[\033[7m\]\[\033[7m\]\u@\h\[\033[0m\] \[\033[4m\]\w\[\033[0m\] ;\n: [\$(date +'%b %e %H:%M')] \!\$ ; "
PS1="\[\033]0;\u@\h:\w\007\]: \[\033[7m\]\[\033[7m\]\u@\h\[\033[0m\] \[\033[4m\]\w\[\033[0m\] ;\n: [\D{%b %d %I:%M%P}] $? \!\$ ; "

# from screen-users
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:"[\033[01;34m\]\w\[\033[00m\]\$ '

HISTFILESIZE=100000
HISTSIZE=10000
HISTTIMEFORMAT="%F %T "

findstr () { find . -type f -exec grep "$1" {} \; -print; }

genpasswd() {
	local l=$1
       	[ "$l" == "" ] && l=20
      	tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
}

# for all config that is only needed by interactive shells

# see http://www.linuxselfhelp.com/howtos/Bash-Prompt/Bash-Prompt-HOWTO-6.html
if [ "$PS1" ]; then
  PS1="\[\033]0;\u@\h:\w\007\]: \[\033[7m\]\[\033[7m\]\u@\h\[\033[0m\] \[\033[4m\]\w\[\033[0m\] ;\n: [\D{%b %d %I:%M%P}] \!\$ ; "

# functions (like aliases but with passing arguments)
  findstr () { find . -type f -exec grep "$1" {} \; -print; }

# Umask setting per PWC compliance for service id
# umask 027

# Default Variable setup
  export TZ=CST6CDT
  export DISPLAY=0.0
  export HISTSIZE=9999
  export HISTFILESIZE=99999
  export HISTTIMEFORMAT="%F %T "

# Default Alias setup
  alias cls=clear
  alias df='df -k'
  alias hogs='du -gs * |sort -rn |head -11'
  alias l='ls -la'
  alias ll='ls -Flas'
  alias ls='ls -sF'
  alias more=less
  alias psg='ps auxwww | grep $1'
  alias ww='whoami;hostname;pwd'
  alias scp='scp -q'
  alias ssh='ssh -q'
fi
