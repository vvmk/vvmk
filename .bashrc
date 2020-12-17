# path dump
export GOPATH=/Users/V/go
export PATH=$PATH:$GOPATH/bin:/Users/V/code/exercism/go
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="~/bin:$PATH"

# use gnu coreutils, keep after /usr/local/sbin
export GNUBINS="/usr/local/opt/findutils/libexec/gnubin:/usr/local/opt/make/libexec/gnubin:/usr/local/opt/gawk/libexec/gnubin:/usr/local/opt/gsed/libexec/gnubin:/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/grep/libexec/gnubin:/usr/local/opt/gnu-tar/libexec/gnubin:/usr/local/opt/coreutils/libexec/gnubin";
export PATH=$bindir:$PATH;

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

EDITOR=vim; export EDITOR

# fix a bug in GNU grep caused by setting GREP_OPTIONS
export GREP_OPTIONS="--color"
alias grep="grep $GREP_OPTIONS"
unset GREP_OPTIONS

alias ls='ls -GFh'
alias lols='ls -GFh | lolcat'
alias pwd='pwd | lolcat'
alias pwdls='pwd && ls'

eval $(thefuck --alias)
alias tinker='php artisan tinker'
alias mfs='php artisan migrate:fresh && php artisan db:seed'
alias jigsaw='./vendor/bin/jigsaw'

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
alias artisan='php artisan'

if [ -x "$(command -v lolcat)" ]; then
  alias cat='lolcat'
fi

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
ohayoo() {
  echo "Good Morning, $USER"
  brew doctor
  brew upgrade
  bash -c '~/.vim/update'
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
satis() {
  php bin/satis build ~/src/satis/satis.json ~/src/satis/web --no-interaction
  php -S localhost:8888 -t ~/src/satis/web/
}
jigsawphp8() {
  composer require --ignore-platform-reqs tightenco/jigsaw
  sed -i 's/"php": "^7.2"/"php": "^7.2|^8.0"/g' composer.lock
  cat <<EOF > composer.json
{
  "repositories": [
    {
      "type": "composer",
      "url": "localhost:8888"
    }
  ],
  "require": {
    "tightenco/jigsaw": "^1.3"
  },
  "config": {
    "secure-http": false
  }
}
EOF
./vendor/bin/jigsaw init vvmk/jigsaw-epicmc2-template:dev-master
}

# added by travis gem
[ -f /Users/V/.travis/travis.sh ] && source /Users/V/.travis/travis.sh
