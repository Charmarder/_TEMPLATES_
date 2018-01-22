umask 027

OS=`(uname -s)`
echo "Operating system: $OS"

## Perl relative vars
alias perl5.20.2="/sbcimp/run/pd/csm/64-bit/perl/5.20.2/bin/perl -I/sbcimp/run/pd/csm/64-bit/cpan/5.20.2-2014.10/lib/"
#alias perl="/sbcimp/run/pd/csm/64-bit/perl/5.16.3/bin/perl"
#export PERL5LIB=/sbcimp/run/pd/csm/64-bit/cpan/5.16.3-2013.03/lib
if [ $OS = "SunOS" ]; then
    PERLDIR="/opt/csm/32-bit/perl/5.16.1"
    CPANLIB="/opt/csm/32-bit/cpan/5.16.1-2012.09/lib"
    MODPERLLIB="/sbcimp/run/pd/apache_modules/2.2.20/mod_perl/2.0.5+perl-5.12.3/lib"
    PERL5LIB="$CPANLIB:$MODPERLLIB"
else
    PERLDIR="/opt/csm/64-bit/perl/5.20.2"
    CPANLIB="/opt/csm/64-bit/cpan/5.20.2-2014.10/lib/"
    PERL5LIB="$CPANLIB"
fi
export PERL5LIB

## SVN relative vars
if [ $OS = "SunOS" ]; then
    SVNDIR="/opt/csm/32-bit/subversion/1.7.7"
    DEPSDIR="/opt/csm/32-bit/deps/1.0.5"    # Dependencies dirictory (need for svn)
else
    SVNDIR="/sbcimp/run/pd/csm/64-bit/subversion/1.7.8"
    DEPSDIR="/opt/csm/64-bit/deps/1.0.7"    # Dependencies dirictory (need for svn)
fi
# needed for some perl modules (use SVN::Client;) 
export LD_LIBRARY_PATH="$SVNDIR/lib:$DEPSDIR/lib"

#OPENSSLDIR="/sbcimp/run/pd/openssl/0.9.8i"

## Oracle relative vars
#ORACLE_HOME="/sbclocal/run/tp/oracle/client/v10.2.0.4-64bit"
#ORACLE_HOME="/sbcimp/run/tp/oracle/client/v11.2.0.3-32bit/client_1/"
ORACLE_HOME="/sbcimp/run/tp/oracle/client/v11.2.0.3-64bit/client_1"
ORACLE_SID="PRISMP1" # used by sqlplus for local db connection
TWO_TASK="PRISMP1"   # used by sqlplus for remote db connection and will overrides the ORACLE_SID
SQLPATH="~"          # where SQL*Plus will search for SQL scripts, including login.sql, including subdirectories
EDITOR="vim"         # for SQL*Plus command 'edit'
export ORACLE_HOME ORACLE_SID TWO_TASK SQLPATH EDITOR 
export LD_LIBRARY_PATH="${ORACLE_HOME}/lib:${LD_LIBRARY_PATH}"

## SyBase relative vars
if [ $OS == "Linux" ]; then
#    export SYBASE=/sbcimp/run/tp/sybase/OpenClientServer/v15.0ebf14845
    export SYBASE=/sbcimp/run/tp/sybase/OpenClientServer/v15.0ebf14855-KRBPRLM
    export LANG=C
else
    export SYBASE=/sbcimp/run/tp/sybase/OpenClientServer/32-Bit/v15.0ebf14833
fi
export SYBASE_OCS=OCS-15_0
export SYBASE_INCLUDE=$SYBASE/$SYBASE_OCS/include
export SYBASE_LIB=$SYBASE/$SYBASE_OCS/lib
export LD_LIBRARY_PATH=$SYBASE_LIB:${LD_LIBRARY_PATH}
export ISQL=$SYBASE/$SYBASE_OCS/bin/isql
export BCP=$SYBASE/$SYBASE_OCS/bin/bcp

## Set PATH variable
if [ $OS = "SunOS" ]; then
    PATH="/sbcimp/run/pd/vim/7.1/bin:$PATH"
    PATH="/sbcimp/run/pd/coreutils/32-bit/6.9/bin:$PATH"
fi
PATH="$ORACLE_HOME/bin:$PERLDIR/bin:$SVNDIR/bin:$DEPSDIR/bin:$PATH"
#PATH=$PATH:/sbcimp/run/pd/gcc/64-bit/latest/bin/
export PATH

## Setup proxy
#export http_proxy=http://DOMAIN\USERNAME:PASSWORD@SERVER:PORT
#export https_proxy=http://DOMAIN\USERNAME:PASSWORD@SERVER:PORT
#export ftp_proxy=http://DOMAIN\USERNAME:PASSWORD@SERVER:PORT
#export HTTPS_PROXY_USERNAME=USERNAME (if required)
#export HTTPS_PROXY_PASSWORD=PASSWORD (if required)
export HTTPS_DEBUG=1
export HTTPS_VERSION=3

## Set up aliases
if [ $OS = "SunOS" ]; then
    if [ -d "/sbcimp/run/pd/coreutils/32-bit/6.9/bin" ]; then
        alias ls='ls -F --color=auto --group-directories-first' 
        alias ll='ls -lF --color=auto --group-directories-first'
    else
        alias ll='ls -lF'
    fi
    export TERM=dtterm
else
    alias ls='ls -F --color=auto --group-directories-first' 
    alias ll='ls -lF --color=auto --group-directories-first' 
    export TERM=xtermc
fi
alias h='history | grep'
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias go='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'

alias got='git '
alias get='git '

## Define colors 
eval $( dircolors -b $HOME/.LS_COLORS )
BROWN='\033[0;33;49m'
CYAN='\033[0;36;49m'
RED='\033[1;31;49m'
GREEN='\033[1;32;49m'
YELLOW='\033[1;33;49m'
PURPLE='\033[1;35;49m'
RESET='\033[0;37;0m'

########## Version Control System functions ##########
# output full current path in SVN repository
svn_url() {
    svn info 2>/dev/null | sed -ne 's#^URL: ##p'
}
# output root path in SVN repository
svn_repository_root() {
    svn info 2>/dev/null | head -n3| tail -1 | awk '{print $3}'
}
# output version control system name and relative path in repository
vcs_branch() {
    # for Subversion
    svn_url | sed -e 's#^'"$(svn_repository_root)"'##g' | \
        awk '{print ":svn" $1}'
    # for Git
    git branch --no-color 2> /dev/null | \
        awk '{print ":git/" $2}'
    # for Mercurial
    hg branch 2> /dev/null | \
        awk '{print":hg/" $1}'
}
# output asterisk (*) if any changes was found
vcs_dirty() {
    # for Subversion
    [ $(svn status 2> /dev/null | wc -l) != 0 ] && \
        echo -e "$RED*$RESET"
    # for Git
    [ $(git status --short 2> /dev/null | wc -l) != 0 ] && \
        echo -e "$RED*$RESET"
    # for Mercurial
    [ $(hg status 2> /dev/null | wc -l) != 0 ] && \
        echo -e "$RED*$RESET"
}

# output asterisk (*) if NFS home derictory is mounted
is_mounted() {
    [ $(df ~ | tail -1 | grep -c '^/') = 0 ] && \
        echo -e "$RED(*)$RESET"
}

## Configure Bash history
export HISTCONTROL=ignoreboth:erasedups      # Avoid duplicate entries in .bash_history
export HISTIGNORE="h *:mc:ls:df:du:bc"       # Commands which are ignored
export HISTSIZE=5000                         # Number of commands that are stored in memory
export HISTFILESIZE=$HISTSIZE                # Number of commands that are allowed in the history file

# Does not work in Solaris
export GREP_OPTIONS='--color=auto'


# bash prompt with Subversion, Git, Mercurial
PS1="\n\[$GREEN\][\D{%H:%M.%S %a, %d %b}] $(is_mounted) \[$YELLOW\]\w\[$PURPLE\] $(vcs_branch) $(vcs_dirty)\n\[$CYAN\][\u@\h]\[$PURPLE\] $ \[$RESET\]" 

#PS1="\n\[$GREEN\][\D{%H:%M.%S %a, %d %b}] $(is_mounted) \[$YELLOW\]\w \n\[$CYAN\][\u@\h]\[$PURPLE\] $ \[$RESET\]" 
#PS1="\n\[$GREEN\][\D{%H:%M.%S %a, %d %b}] \[$YELLOW\]\w \n\[$CYAN\][\u@\h]\[$PURPLE\] \[\033(0\]b\[\033(B\] \[$RESET\]" 
export PS1

#export PS1="\n\[\033[32m\][\D{%H:%M.%S %a, %d %b}] \[\033[33m\]\w \n\[\033[36m\][\u@\h]\[\033[35m\] $ \[\033[0m\]"


#echo ${PATH}:/usr/bin | perl -aF: -ple'$_=join":",grep{!$o{$_}++}@F'
#PATH=`awk -F: '{for(i=1;i<=NF;i++){if(!a[$i]++)printf s$i;s=":"}}'<<<$PATH`
#export SVN_EDITOR='vim -c "new|silent r! svn diff" -c "set syntax=diff buftype=nofile" -c "silent 1|wincmd j"'


. ~/ubs/UBond/app/UbsTask/bin/setup.env

