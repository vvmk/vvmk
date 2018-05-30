
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
mkcd () {
    case "$1" in
    */..|*/../) cd -- "$1";; # that doesn't make any sense unless the directory already exists
    /*/../*) (cd "${1%/../*}/.." && mkdir -p "./${1##*/../}") && cd -- "$1";;
    /*) mkdir -p "$1" && cd "$1";;
    */../*) (cd "./${1%/../*}/.." && mkdir -p "./${1##*/../}") && cd "./$1";;
    ../*) (cd .. && mkdir -p "${1#.}") && cd "$1";;
    *) mkdir -p "./$1" && cd "./$1";;
  esac
}
function gi() {
    curl -L -s https://www.gitignore.io/api/$@ ;
}
function ohayo() {
    echo "Good Morning, $USER"
    brew doctor;
    brew upgrade;
}

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
