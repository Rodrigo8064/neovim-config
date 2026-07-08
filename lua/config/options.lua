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

-- Linha guia de coluna
opt.colorcolumn = "79"

vim.g.python3_host_prog = vim.fn.expand("~/.pyenv/shims/python3")

-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

