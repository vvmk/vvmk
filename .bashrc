# path dump
export GOPATH=/Users/v/go
export PATH=$PATH:$GOPATH/bin:/Users/v/code/exercism/go
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
  alias lcat='lolcat'
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
  echo "Good Morning, Miss Violet."
  brew doctor
  brew upgrade
  composer global upgrade
  npm install -g npm
  nvm install node
  npm doctor
  for i in ~/.vim/bundle/*; do git -C $i pull; done
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
  cd ~/src/satis
  php bin/satis build --no-interaction ~/src/satis/satis.json ~/src/satis/web 
  php -S localhost:8888 -t ~/src/satis/web/
}
slugify () {
      echo "$1" | iconv -c -t ascii//TRANSLIT | sed -E 's/[~^]+//g' | sed -E 's/[^a-zA-Z0-9]+/-/g' | sed -E 's/^-+|-+$//g' | tr A-Z a-z | tr -d '\n'
}

# added by travis gem
[ -f /Users/v/.travis/travis.sh ] && source /Users/v/.travis/travis.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
