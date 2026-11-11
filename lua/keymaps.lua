vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Salvar e sair
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Salvar" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Fechar" })

-- Navegar entre splits
map("n", "<C-h>", "<C-w>h", { desc = "Split esquerdo" })
map("n", "<C-l>", "<C-w>l", { desc = "Split direito" })
map("n", "<C-j>", "<C-w>j", { desc = "Split abaixo" })
map("n", "<C-k>", "<C-w>k", { desc = "Split acima" })

-- Mover linhas selecionadas
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Mover linha abaixo" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Mover linha acima" })

-- Manter cursor no centro ao rolar
map("n", "<C-d>", "<C-d>zz", { desc = "Rolar baixo" })
map("n", "<C-u>", "<C-u>zz", { desc = "Rolar cima" })
map("n", "}", "}zz", { silent = true })
map("n", "{", "{zz", { silent = true })

-- Substituir palavra sob o cursor
map("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Substituir palavra" })

-- Terminal integrado (toggle)
local term_buf, term_win = -1, -1

map("n", "<leader>tt", function()
  if vim.api.nvim_win_is_valid(term_win) then
    vim.api.nvim_win_hide(term_win)
    return
  end
  vim.cmd("botright 15split")
  term_win = vim.api.nvim_get_current_win()
  if vim.api.nvim_buf_is_valid(term_buf) then
    vim.api.nvim_win_set_buf(term_win, term_buf)
  else
    vim.cmd.terminal()
    term_buf = vim.api.nvim_get_current_buf()
  end
  vim.cmd.startinsert()
end, { desc = "Toggle terminal" })

map("n", "<leader>tv", "<cmd>vsplit | terminal<CR>", { desc = "Terminal vertical" })
map("n", "<leader>tx", "<cmd>split | terminal<CR>", { desc = "Terminal horizontal" })

-- Modo terminal
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Sair do modo terminal" })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Ir para split acima" })
