#!/usr/bin/env bash
echo "🙈 Make dirs..."
mkdir ~/.vim
mkdir ~/.vim/bundle
mkdir ~/.vim/colors
mkdir ~/.vim/autoload
echo "🙉 Clone vim plugins..."
git clone git@github.com:vvmk/angular-cli.vim.git /Users/V/.vim/bundle/angular-cli.vim
git clone https://github.com/hdima/python-syntax.git /Users/V/.vim/bundle/python-syntax
git clone https://github.com/felixhummel/setcolors.vim.git /Users/V/.vim/bundle/setcolors.vim
git clone git://github.com/godlygeek/tabular.git /Users/V/.vim/bundle/tabular
git clone git@github.com:vvmk/typescript-vim-vvmk.git /Users/V/.vim/bundle/typescript-vim-vvmk
git clone git://github.com/tpope/vim-bundler.git /Users/V/.vim/bundle/vim-bundler
git clone https://github.com/flazz/vim-colorschemes.git /Users/V/.vim/bundle/vim-colorschemes
git clone https://github.com/tpope/vim-dispatch.git /Users/V/.vim/bundle/vim-dispatch
git clone https://github.com/tpope/vim-fugitive.git /Users/V/.vim/bundle/vim-fugitive
git clone https://github.com/fatih/vim-go.git /Users/V/.vim/bundle/vim-go
git clone https://github.com/pangloss/vim-javascript.git /Users/V/.vim/bundle/vim-javascript
git clone git://github.com/tpope/vim-rails.git /Users/V/.vim/bundle/vim-rails
git clone https://github.com/tpope/vim-sensible.git /Users/V/.vim/bundle/vim-sensible
git clone https://github.com/tpope/vim-sleuth.git /Users/V/.vim/bundle/vim-sleuth
git clone https://github.com/tpope/vim-surround.git /Users/V/.vim/bundle/vim-surround
git clone https://github.com/tpope/vim-unimpaired.git /Users/V/.vim/bundle/vim-unimpaired
git clone https://github.com/tpope/vim-vinegar.git /Users/V/.vim/bundle/vim-vinegar
echo "🙊 Putting things where they belong..."
mv ./autoload/* ~/.vim/autoload/
mv ./.vimrc ~/.vimrc
mv ./.bash_profile ~/.bash_profile
mv ./.profile ~/.profile
mv ./.bashrc ~/.bashrc
mv ./.gitconfig ~/.gitconfig
mv ./.cvsignore ~/.cvsignore
echo "🐒 Done!"
