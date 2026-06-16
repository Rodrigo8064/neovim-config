local opt = vim.opt

-- Números de linha
opt.number = true
opt.relativenumber = true

-- Indentação
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Visual
opt.termguicolors = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.scrolloff = 8

-- Busca
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- Comportamento
opt.splitbelow = true
opt.splitright = true
opt.clipboard = "unnamedplus"
opt.updatetime = 250

-- Linha guia de coluna
opt.colorcolumn = "79"
