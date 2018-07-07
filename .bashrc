# path dump
export GOPATH=/Users/V/go
export PATH=$PATH:$GOPATH/bin:/Users/V/code/exercism/go
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.composer/vendor/bin:$PATH"

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

eval $(/usr/libexec/path_helper -s)

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# shell customization {
export PS1="\[\033[36m\]\u\[\033[0m\]\$\[\e[0m\] "
export CLICOLOR=1
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
# }

# aliases
alias ls='ls -GFh'

# fix a bug in GNU grep caused by setting GREP_OPTIONS {
export GREP_OPTIONS="--color"
alias grep="/usr/bin/grep $GREP_OPTIONS"
unset GREP_OPTIONS
# }

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
    docker exec -it "$1" bash
}
