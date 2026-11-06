local opt = vim.opt

-- Números de linha
opt.number = true
opt.relativenumber = true

-- Indentação
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.softtabstop = 2

-- Visual
opt.termguicolors = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.scrolloff = 12
opt.winborder = 'rounded'
vim.opt.shiftround = true
opt.title = true
opt.showbreak = '↪'
opt.breakindent = true
opt.completeopt:append 'popup'

-- Busca
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- Comportamento
opt.splitbelow = true
opt.splitright = true
opt.clipboard = "unnamedplus"
opt.updatetime = 250
opt.undofile = true
opt.confirm = true
vim.opt.updatetime = 400

-- dobrar/recolher blocos
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevel = 99 
vim.opt.foldlevelstart = 99

-- Linha guia de coluna
opt.colorcolumn = "79"
vim.g.loaded_python3_provider = 0
