#!/usr/bin/env bash
echo "🔥 Creating vim subdirs🔥"
mkdir ~/.vim
mkdir ~/.vim/bundle
mkdir ~/.vim/colors
mkdir ~/.vim/autoload
echo "🔥 Moving subdirectories to ~/.vim/🔥"
mv ./bundle/* ~/.vim/bundle/
mv ./colors/* ~/.vim/colors/
mv ./autoload/* ~/.vim/autoload/
mv ./.vimrc ~/.vimrc
echo "🔥 Downloading plugins...🔥"
git clone https://github.com/ctrlpvim/ctrlp.vim ~/.vim/bundle/ctrlp.vim
git clone https://github.com/godlygeek/tabular ~/.vim/bundle/tabular
git clone https://github.com/tpope/vim-surround ~/.vim/bundle/vim-surround
git clone https://github.com/tpope/vim-rails ~/.vim/bundle/vim-rails
git clone https://github.com/pangloss/vim-javascript ~/.vim/bundle/vim-javascript
git clone https://github.com/tpope/vim-bundler ~/.vim/bundle/vim-bundler
git clone https://github.com/hdima/python-syntax ~/.vim/bundle/python-syntax
git clone https://github.com/altercation/vim-colors-solarized ~/.vim/bundle/vim-colors-solarized
git clone https://github.com/tpope/vim-fugitive.git ~/.vim/bundle/vim-fugitive.git
echo "🔥 Moving config🔥"
mv ./.bash_profile ~/.bash_profile
mv ./.bashrc ~/.bashrc
mv ./.gitconfig ~/.gitconfig
mv ./.gitignore_global ~/.gitignore_global
echo "🔥 Done!🔥"
