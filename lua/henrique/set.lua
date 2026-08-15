vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = ""

vim.g.mapleader = " "

vim.opt.swapfile = true
vim.opt.cursorline = true

-- vim.opt.foldmethod = "manual"
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.opt.foldexpr = "v:lua.extend_foldexpr(v:lnum)"
vim.opt.foldcolumn = "0"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.fillchars = { fold = " " }

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.o.exrc = true
vim.o.secure = true
