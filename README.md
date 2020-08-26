# vimrc

to install:
clone this repo

cd into it
```
brew install neovim/neovim/neovim
ln -s .vimrc ~/.vimrc
ln -s .vimrc ~/.config/nvim/init.vim
mkdir ~/.vim/backup
mkdir ~/.vim/swap
mkdir ~/.vim/undo
git clone git@github.com:VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
nvim +PluginInstall +qall
```
requires solarized colors in your terminal: http://ethanschoonover.com/solarized
