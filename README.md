# vimrc

to install:
First, visit [solarized](https://ethanschoonover.com/solarized/) and click on the download link.

clone this repo

cd into it
```
brew install neovim/neovim/neovim
ln -s ~/vimrc/.vimrc ~/.vimrc
ln -s ~/vimrc/.vimrc ~/.config/nvim/init.vim
mkdir ~/.vim/backup
mkdir ~/.vim/swap
mkdir ~/.vim/undo
mkdir ~/.vim/colors
cp ~/Downloads/solarized/vim-colors-solarized/colors/solarized.vim ~/.vim/colors
git clone git@github.com:VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
nvim +PluginInstall +qall
```

## Notes

### Tracing Code
To trace code / variables inside a file, you get your cursor on a word/symbol and hit `*`, which takes you to the next instance. To trace code through different files, you hit `<ctlr+]>`, which does a `ctags` tag search. `<ctrl+t>` rewinds that search to get you back to where you were originally.

### Managing Multiple Buffers

Rather than supporting tabs or a tabline or something, I just use vim buffers and have fuzzy searching.

`<ctrl+p>` opens up the full-repo fuzzy finder, and `<ctrl+b>` opens up the open-files fuzzy finder. ,`<tab>` switches the window to your most recent file.

`-` opens up the file directory at the file that you're editing and pressing `-` more continues to back you out. `jkl;` navigates as normal and `<enter>` brings you into that file.

### Navigating Within a File

All of the normal vim commands apply here, so understanding text objects helps a bunch. `w`, `e`, `b`, etc. On top of that, you can press `,,w` (or any text object key stroke after `,,` to highlight warp points.

### Multi-Cursor Editing

If you need to re-name a variable, or just generally do a lot of repetitive editing, hovering over a word and then hitting `<ctrl+n>` will bring up a new cursor on the next instance of the word for each time you press it. Any keystrokes will apply to each cursor until you clear them with `<esc>`
