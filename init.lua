
vim.cmd([[
call plug#begin()
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
call plug#end()
]])


vim.g.mapleader = "," -- Make sure to set `mapleader` before lazy so your mappings are correct
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  "faerryn/user.nvim",
  "Lokaltog/vim-easymotion",
  "altercation/vim-colors-solarized",
  "bronson/vim-trailing-whitespace",
  "ervandew/supertab",
  "flazz/vim-colorschemes",
  "jeetsukumaran/vim-filebeagle",
  "jiangmiao/auto-pairs",
  "tpope/vim-dispatch",
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "tpope/vim-sensible",
  "pangloss/vim-javascript",
  "vim-ruby/vim-ruby",
  "derekwyatt/vim-scala"
})

local map = function(mode, key, command, options)
  options = options or {}
  vim.api.nvim_set_keymap(mode, key, command, options)
end

vim.cmd([[
set rtp+=~/.fzf
syntax on
set omnifunc=syntaxcomplete#Complete
syntax enable
set background=dark
colorscheme solarized
call togglebg#map("<F6>")
set diffopt+=vertical
set clipboard=unnamedplus
set nohlsearch
set splitright
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//
set ignorecase
set smartcase
set shell=bash
set showcmd
set guifont=Source\ Code\ Pro:h15
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/target/*,*.json,*.css,*/it-classes/*
set history=1000
]])

vim.g.session_autosave = "no"
vim.g.filebeagle_show_hidden = true

vim.cmd([[
set number
set grepprg=ag
set hidden
set lazyredraw
set smarttab
set matchtime=2
set tabstop=2 shiftwidth=2 expandtab
set cc=121
set complete=.,w,b,u,t,i
set ttyfast
set mouse=a
]])

-- FZF
vim.g.fzf_command_prefix = "Fzf"
map('n', '<C-p>', ':FzfGFiles<CR>', { noremap = true })
map('n', '<C-b>', ':FzfBuffers<CR>', { noremap = true })
map('n', '<Tab>', ':b#<CR>', { silent = true })


vim.g.SuperTabDefaultCompletionType = "<c-p>"

vim.g.easytags_async = 1

vim.g.terminal_scrollback_buffer_size = 100000


vim.g.session_autoload = "no"

vim.cmd([[
set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P
]]
)
