# path dump
export GOPATH=/Users/V/go
export PATH=$PATH:$GOPATH/bin:/Users/V/code/exercism/go
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="~/bin:$PATH"

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

EDITOR=vim; export EDITOR

# WSL refuses to set umask properly.
if [ "$(umask)" = "0000" ]; then
    umask 002
fi

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*) machine=Linux;;
    Darwin*) machine=Mac;;
    CYGWIN*) machine=Cygwin;;
    MINGW*) machine=MinGw;;
    *) machine="UNKNOWN:${unameOut}"
esac

if [ "$machine" = "Darwin" ]; then
    eval $(/usr/libexec/path_helper -s)

    # fix a bug in GNU grep caused by setting GREP_OPTIONS
    export GREP_OPTIONS="--color"
    alias grep="/usr/bin/grep $GREP_OPTIONS"
    unset GREP_OPTIONS

    alias ls='ls -GFh'
fi

if [ "$machine" = "Linux" ]; then
    alias ls='ls -Fh --color'
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
alias gl='git lol'
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
    eval $(ssh-agent -s)
    ssh-add "$1"
}
# TODO: only works for origin/branch, add support for different remotes
chremote() {
    remote='origin'
    git checkout -b "$1"
    git pull "$remote" "$1"
}

# added by travis gem
[ -f /Users/V/.travis/travis.sh ] && source /Users/V/.travis/travis.sh
