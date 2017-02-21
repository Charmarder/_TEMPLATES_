umask 027

SYSTEM=`(uname -s)`

## Oracle relative vars
#ORACLE_HOME="/sbclocal/run/tp/oracle/client/v10.2.0.4-64bit"
#ORACLE_HOME="/sbcimp/run/tp/oracle/client/v11.2.0.3-32bit/client_1/"
ORACLE_HOME="/sbcimp/run/tp/oracle/client/v11.2.0.3-64bit/client_1"
ORACLE_SID="PRISMP1" # used by sqlplus for local db connection
TWO_TASK="PRISMP1"   # used by sqlplus for remote db connection and will overrides the ORACLE_SID
SQLPATH="~"          # where SQL*Plus will search for SQL scripts, including login.sql, including subdirectories
EDITOR="vim"         # for SQL*Plus command 'edit'

export ORACLE_HOME ORACLE_SID TWO_TASK SQLPATH EDITOR 

## Perl relative vars
MYLIB="$HOME/ubs/RemEx/app/SASSE/lib"
if [ $SYSTEM = "SunOS" ]; then
    #PERLDIR="/sbcimp/run/pd/csm/32-bit/perl/5.12.3"
    #CPANLIB="/sbcimp/run/pd/csm/32-bit/cpan/5.12.3-2011.03/lib"
    PERLDIR="/opt/csm/32-bit/perl/5.16.1"
    CPANLIB="/opt/csm/32-bit/cpan/5.16.1-2012.09/lib"

    MODPERLLIB="/sbcimp/run/pd/apache_modules/2.2.20/mod_perl/2.0.5+perl-5.12.3/lib"
    PERL5LIB="$MYLIB:$CPANLIB:$MODPERLLIB"
else
    PERLDIR="/opt/csm/64-bit/perl/5.20.2"
    CPANLIB="/opt/csm/64-bit/cpan/5.20.2-2014.10/lib/"

    PERL5LIB="$MYLIB:$CPANLIB"
fi

## SVN relative vars
if [ $SYSTEM = "SunOS" ]; then
    SVNDIR="/opt/csm/32-bit/subversion/1.7.7"
else
    SVNDIR="/sbcimp/run/pd/csm/64-bit/subversion/1.7.8"
fi

## Dependencies dirictory
if [ $SYSTEM = "SunOS" ]; then
    DEPSDIR="/opt/csm/32-bit/deps/1.0.5"     # need for svn
else
    DEPSDIR="/opt/csm/64-bit/deps/1.0.7"     # need for svn
fi

#OPENSSLDIR="/sbcimp/run/pd/openssl/0.9.8i"


# needed for some perl modules (use SVN::Client;) 
LD_LIBRARY_PATH="$ORACLE_HOME/lib:$SVNDIR/lib:$DEPSDIR/lib"

if [ $SYSTEM = "SunOS" ]; then
    PATH="/sbcimp/run/pd/vim/7.1/bin:$PATH"
    PATH="/sbcimp/run/pd/coreutils/32-bit/6.9/bin:$PATH"
fi
PATH="$ORACLE_HOME/bin:$PERLDIR/bin:$SVNDIR/bin:$DEPSDIR/bin:$PATH"

export PATH LD_LIBRARY_PATH PERL5LIB

# set up aliases
if [ $SYSTEM = "SunOS" ]; then
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

# Define colors 
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
#PS1="\[$GREEN\][\t]\[$RED\][\[$CYAN\]\u@\h:\[$YELLOW\]\w\[$RED\]]\[$PURPLE\] $ \[$RESET\]"
#PS1="\n\[$GREEN\][\D{%H:%M.%S %a, %d %b}] \[$YELLOW\]\w \[$PURPLE\]\$(vcs_branch)\n\[$CYAN\][\u@\h]\[$PURPLE\] $ \[$RESET\]" 
PS1="\n\[$GREEN\][\D{%H:%M.%S %a, %d %b}] $(is_mounted) \[$YELLOW\]\w \n\[$CYAN\][\u@\h]\[$PURPLE\] $ \[$RESET\]" 
#PS1="\n\[$GREEN\][\D{%H:%M.%S %a, %d %b}] \[$YELLOW\]\w \n\[$CYAN\][\u@\h]\[$PURPLE\] \[\033(0\]b\[\033(B\] \[$RESET\]" 
export PS1

#export PS1="\n\[\033[32m\][\D{%H:%M.%S %a, %d %b}] \[\033[33m\]\w \n\[\033[36m\][\u@\h]\[\033[35m\] $ \[\033[0m\]"


#echo ${PATH}:/usr/bin | perl -aF: -ple'$_=join":",grep{!$o{$_}++}@F'
#PATH=`awk -F: '{for(i=1;i<=NF;i++){if(!a[$i]++)printf s$i;s=":"}}'<<<$PATH`
#export SVN_EDITOR='vim -c "new|silent r! svn diff" -c "set syntax=diff buftype=nofile" -c "silent 1|wincmd j"'
