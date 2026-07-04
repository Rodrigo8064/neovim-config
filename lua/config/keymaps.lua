local map = vim.keymap.set

-- Leader key (barra de espaço como tecla principal)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Salvar e sair
map("n", "<leader>w", ":w<CR>", { desc = "Salvar" })
map("n", "<leader>q", ":q<CR>", { desc = "Fechar" })

-- Navegar entre splits
map("n", "<C-h>", "<C-w>h", { desc = "Split esquerdo" })
map("n", "<C-l>", "<C-w>l", { desc = "Split direito" })
map("n", "<C-j>", "<C-w>j", { desc = "Split abaixo" })
map("n", "<C-k>", "<C-w>k", { desc = "Split acima" })

-- Mover linhas selecionadas (modo visual)
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Mover linha abaixo" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Mover linha acima" })

-- Manter cursor no centro ao rolar
map("n", "<C-d>", "<C-d>zz", { desc = "Rolar baixo" })
map("n", "<C-u>", "<C-u>zz", { desc = "Rolar cima" })

-- Lazygit
map("n", "<leader>gg", function()
  vim.cmd("botright 15split | terminal lazygit")
  vim.cmd("startinsert")
end, { desc = "Lazygit" })

-- for search and replace
map('n', '<leader>r', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Search and replace' })

-- navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')


