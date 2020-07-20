# path dump
export GOPATH=/Users/V/go
export PATH=$PATH:$GOPATH/bin:/Users/V/code/exercism/go
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="~/bin:$PATH"

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

EDITOR=vim; export EDITOR

# WSL refuses to set umask properly.
if [ "$(umask)" = "0000" ]; then
    umask 022
fi

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*) machine=Linux;;
    Darwin*) machine=Mac;;
    CYGWIN*) machine=Cygwin;;
    MINGW*) machine=MinGw;;
    *) machine="UNKNOWN:${unameOut}"
esac

if [ "$machine" = "Mac" ]; then
    export PATH="$HOME/.composer/vendor/bin:$PATH"
    eval $(/usr/libexec/path_helper -s)

    # fix a bug in GNU grep caused by setting GREP_OPTIONS
    export GREP_OPTIONS="--color"
    alias grep="/usr/bin/grep $GREP_OPTIONS"
    unset GREP_OPTIONS

    alias ls='ls -GFh'
    alias lols='ls -GFh | lolcat'
    alias pwd='pwd | lolcat'
    alias pwdls='pwd && ls'
fi

if [ "$machine" = "Linux" ]; then
    export PATH="$HOME/.config/composer/vendor/bin:$PATH"

    alias ls='ls -Fh --color'
    export GITHUB_KEY_LOCATION=~/.ssh/github_vvmk_trellist
    export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
fi

if [ "$machine" = "Cygwin" ]; then
    export GITHUB_KEY_LOCATION=~/.ssh/github_vvmk_trellist.pub
    export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
    remnt() {
        umount $1
        mount -t drvfs C: $1 -o metadata,uid=1000,gid=1000,umask=22,case=off
    }
fi
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# shell customization {
export PS1="\[\033[36m\]\u\[\033[0m\]\$\[\e[0m\] "
export CLICOLOR=1
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
# }

# aliases - all
alias vd='echo'
alias v='vim'
alias g='git'
alias cl='clear'
alias gl='cl && git lol'
alias gb='git branch'
alias art='php artisan'

if [ -x "$(command -v lolcat)" ]; then
    alias cat='lolcat'
fi

alias w~='cd /c/Users/vmasiello'
export PGHW='/c/src/pgh-student/PGHGlobal.Web'

mkcd() {
    case "$1" in
      */..|*/../) cd -- "$1";; # that doesn't make any sense unless the directory already exists
      /*/../*) (cd "${1%/../*}/.." && mkdir -p "./${1##*/../}") && cd -- "$1";;
      /*) mkdir -p "$1" && cd "$1";;
      */../*) (cd "./${1%/../*}/.." && mkdir -p "./${1##*/../}") && cd "./$1";;
      ../*) (cd .. && mkdir -p "${1#.}") && cd "$1";;
      *) mkdir -p "./$1" && cd "./$1";;
    esac
}
gi() {
    curl -L -s https://www.gitignore.io/api/$@ ;
}
ohayo() {
    echo "Good Morning, $USER"
    brew doctor
    brew upgrade
    bash -c '~/.vim/update'
}
mvnquick() {
    mvn archetype:generate -DgroupId=$1 -DartifactId=$2 \
        -DarchetypeArtifactId=maven-archetype-quickstart \
        -DinteractiveMode=false
}
usejava() {
    export JAVA_HOME=`/usr/libexec/java_home -v $1`
    java -version
}
dockersh() {
    docker container exec -it "$1" sh
}
gosrc() {
    cd "$GOPATH/src/github.com/vvmk/$1"
}
addkey() {
    if [[ -z $1 ]]; then
        arg=$GITHUB_KEY_LOCATION
    else
        arg=$1
    fi
    eval $(ssh-agent -s)
    ssh-add $arg
}

git-big() {
    if [[ -z $1 ]]; then
        arg=20
    else
        arg1=$1
    fi

    git rev-list master | while read rev; do git ls-tree -lr $rev  | cut -c54- | sed -r 's/^ +//g;'; done  | sort -u | perl -e 'while (<>) { chomp; @stuff=split("\t");$sums{$stuff[1]} += $stuff[0];} print "$sums{$_} $_\n" for (keys %sums);' | sort -rn | head -n $arg
}

git-purge() {
if [[ -z $1 ]]; then
    echo "error: missing arg: path"
    echo "Usage: git-purge <path_to_file(s)_to_purge>"
fi
    git filter-branch --force --index-filter "git rm --cached --ignore-unmatch $1" --prune-empty --tag-name-filter cat -- --all
}

git-all() {
    find . -mindepth 1 -maxdepth 1 -type d -print -exec git -C {} $1 \;
>>>>>>> origin/master
}

# added by travis gem
[ -f /Users/V/.travis/travis.sh ] && source /Users/V/.travis/travis.sh
