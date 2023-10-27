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
  "junegunn/fzf",
  "junegunn/fzf.vim",
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
  "derekwyatt/vim-scala",
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
    }
  },
  {
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    }
  }
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

-- Metals
vim.opt_global.completeopt = { "menuone", "noinsert", "noselect" }
-- LSP mappings
vim.keymap.set("n", "gD",  vim.lsp.buf.definition)
vim.keymap.set("n", "K",  vim.lsp.buf.hover)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "gds", vim.lsp.buf.document_symbol)
vim.keymap.set("n", "gws", vim.lsp.buf.workspace_symbol)
vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run)
vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

-- all workspace diagnostics
vim.keymap.set("n", "<leader>aa", vim.diagnostic.setqflist)

-- all workspace errors
vim.keymap.set("n", "<leader>ae", function()
  vim.diagnostic.setqflist({ severity = "E" })
end)

-- all workspace warnings
vim.keymap.set("n", "<leader>aw", function()
  vim.diagnostic.setqflist({ severity = "W" })
end)

-- buffer diagnostics only
vim.keymap.set("n", "<leader>d", vim.diagnostic.setloclist)

vim.keymap.set("n", "[c", function()
  vim.diagnostic.goto_prev({ wrap = false })
end)

vim.keymap.set("n", "]c", function()
  vim.diagnostic.goto_next({ wrap = false })
end)



-- completion related settings
-- This is similiar to what I use
local cmp = require("cmp")
cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "vsnip" },
  },
  snippet = {
    expand = function(args)
      -- Comes from vsnip
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    -- None of this made sense to me when first looking into this since there
    -- is no vim docs, but you can't have select = true here _unless_ you are
    -- also using the snippet stuff. So keep in mind that if you remove
    -- snippets you need to remove this select
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    -- I use tabs... some say you should stick to ins-completion but this is just here as an example
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  }),
})

----------------------------------
-- LSP Setup ---------------------
----------------------------------
local metals_config = require("metals").bare_config()

-- Example of settings
metals_config.settings = {
  showImplicitArguments = true,
  excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}

-- *READ THIS*
-- I *highly* recommend setting statusBarProvider to true, however if you do,
-- you *have* to have a setting to display this in your statusline or else
-- you'll not see any messages from metals. There is more info in the help
-- docs about this
-- metals_config.init_options.statusBarProvider = "on"

-- Example if you are using cmp how to make sure the correct capabilities for snippets are set
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()


-- Autocmd that will actually be in charging of starting the whole thing
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  -- NOTE: You may or may not want java included here. You will need it if you
  -- want basic Java support but it may also conflict if you are using
  -- something like nvim-jdtls which also works on a java filetype autocmd.
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})
