
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

git clone git@github.com:vvmk/angular-cli.vim.git /Users/V/.vim/bundle/angular-cli.vim
git clone https://github.com/ctrlpvim/ctrlp.vim.git /Users/V/.vim/bundle/ctrlp.vim
git clone https://github.com/hdima/python-syntax.git /Users/V/.vim/bundle/python-syntax
git clone https://github.com/felixhummel/setcolors.vim.git /Users/V/.vim/bundle/setcolors.vim
git clone git://github.com/godlygeek/tabular.git /Users/V/.vim/bundle/tabular
git clone https://github.com/leafgarland/typescript-vim.git /Users/V/.vim/bundle/typescript-vim
git clone git://github.com/tpope/vim-bundler.git /Users/V/.vim/bundle/vim-bundler
git clone https://github.com/altercation/vim-colors-solarized.git /Users/V/.vim/bundle/vim-colors-solarized
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

echo "🔥 Moving config🔥"
mv ./.bash_profile ~/.bash_profile
mv ./.bashrc ~/.bashrc
mv ./.gitconfig ~/.gitconfig
mv ./.gitignore_global ~/.gitignore_global
echo "🔥 Done!🔥"

