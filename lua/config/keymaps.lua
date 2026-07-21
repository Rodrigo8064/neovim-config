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
map("n", "}", "}zz", { noremap = true, silent = true })
map("n", "{", "{zz", { noremap = true, silent = true })

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

-- Terminal integrado v2
local term_buf = -1
local term_win = -1

map("n", "<leader>t", function()
  if vim.api.nvim_win_is_valid(term_win) then
    vim.api.nvim_win_hide(term_win)
  else
    vim.cmd("botright 15split")
    local new_win = vim.api.nvim_get_current_win()
    if vim.api.nvim_buf_is_valid(term_buf) then
      vim.api.nvim_win_set_buf(new_win, term_buf)
    else
      local new_buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_win_set_buf(new_win, new_buf)
      vim.fn.termopen(os.getenv("SHELL"))
      term_buf = vim.api.nvim_get_current_buf()
    end
    term_win = new_win
    vim.cmd("startinsert")
  end
end, { desc = "Toggle terminal" })

-- Abre o terminal em uma divisão horizontal (como se fosse o Ctrl + x do Telescope)
map('n', '<leader>tv', ':vsplit | terminal<CR>', { desc = 'Abrir terminal vertical' })

-- Abre o terminal em uma divisão horizontal (como se fosse o Ctrl + x do Telescope)
map('n', '<leader>tx', ':split | terminal<CR>', { desc = 'Abrir terminal horizontal' })

-- Sair do modo insert do terminal sem fechar
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Sair do modo terminal" })

-- Navegar do terminal para o código com Ctrl+k
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Ir para split acima" })

-- Fechar terminal com leader+t também no modo terminal
map("t", "<leader>t", "<C-\\><C-n>:lua vim.api.nvim_win_hide(0)<CR>", { desc = "Fechar terminal" })

-- neotest
vim.keymap.set("n", "<leader>tr", function() 
  require("neotest").run.run() 
end, { desc = "Rodar teste mais próximo" })

-- 2. Roda todos os testes do arquivo atual
vim.keymap.set("n", "<leader>tf", function() 
  require("neotest").run.run(vim.fn.expand("%")) 
end, { desc = "Rodar testes do arquivo" })

-- 3. Abre/fecha o painel lateral com a lista e status de todos os testes
vim.keymap.set("n", "<leader>ts", function() 
  require("neotest").summary.toggle() 
end, { desc = "Alternar painel de testes" })

-- 4. Abre o resultado detalhado (output) do teste em uma janela flutuante
vim.keymap.set("n", "<leader>to", function() 
  require("neotest").output.open({ enter = true }) 
end, { desc = "Mostrar resultado do teste" })
