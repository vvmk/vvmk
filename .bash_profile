export GOPATH=/Users/V/code/go
export XAMPPPATH=/Applications/XAMPP/xamppfiles
export PATH=$GOPATH/bin:$PATH:$XAMPPPATH:$XAMPPPATH/bin:/Users/V/code/exercism/go
eval $(/usr/libexec/path_helper -s)

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PS1="\[\033[36m\]\u\[\033[0m\]\$\[\e[0m\] "
export CLICOLOR=1
# export LSCOLORS="ExFxCxDxBxegedabagacad"
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
export GREP_OPTIONS="--color"
alias ls='ls -GFh'
source /Users/V/.bashrc
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}
function ohayo() {
    echo "Good Morning, $USER"
    brew doctor;
    brew upgrade;
}
