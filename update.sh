#!/usr/bin/env bash

CWD=$(pwd)
cd ~/.vim/

echo 🔥 Copying files...🔥

cp ~/.vimrc ~/.vim/
cp ~/.cvsignore ~/.vim/
cp ~/.gitconfig ~/.vim/
cp ~/.bash_profile ~/.vim/
cp ~/.bashrc ~/.vim

echo 🔥 Generating landing script...🔥

echo '#!/usr/bin/env bash
echo "🔥 Creating vim subdirs🔥"
mkdir ~/.vim
mkdir ~/.vim/bundle
mkdir ~/.vim/colors
mkdir ~/.vim/autoload
echo "🔥 Downloading plugins...🔥"' >~/.vim/landing.sh

# the revised first half 
find ~/.vim/bundle/*/.git/config | xargs -n 1 ggrep -Po 'url = \K.*.git' | xargs -n 1 -I {} bash -c 'echo git clone {}' >~/.vim/vvtemppart1
# then create the second half from the first
cat ~/.vim/vvtemppart1 | ggrep -Po '^.*github.com(:|/).+/\K.*(?=\.git)' | xargs -n 1 -I {} bash -c 'echo ~/.vim/bundle/{};' >~/.vim/vvtemppart2

# join em
paste -d " " ~/.vim/vvtemppart1 ~/.vim/vvtemppart2 >>~/.vim/landing.sh

echo 'echo "🔥 Putting things where they belong...🔥"
mv ./autoload/* ~/.vim/autoload/
mv ./.vimrc ~/.vimrc
mv ./.bash_profile ~/.bash_profile
mv ./.bashrc ~/.bashrc
mv ./.gitconfig ~/.gitconfig
mv ./.cvsignore ~/.cvsignore
echo "🔥 Done!🔥"' >> ~/.vim/landing.sh

# clean up
rm ~/.vim/vvtemppart*

echo 🔥 Git...🔥

git add .vimrc .cvsignore .gitconfig .bash_profile .bashrc landing.sh colors/*
git commit -m "run auto-update"
git push origin master

# back to where we started
cd $CWD

echo '🔥 Done! 🔥'
