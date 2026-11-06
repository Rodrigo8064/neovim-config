vim.pack.add({
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-neotest/neotest",
  "https://github.com/nvim-neotest/neotest-python",
})

require("neotest").setup({
  adapters = {
    require("neotest-python")({ runner = "pytest" }),
  },
  status = { virtual_text = true },
  output = { open_on_run = true },
})

local nt = require("neotest")
local map = vim.keymap.set

map("n", "<leader>tr", function() nt.run.run() end, { desc = "Rodar teste mais próximo" })
map("n", "<leader>tf", function() nt.run.run(vim.fn.expand("%")) end, { desc = "Rodar testes do arquivo" })
map("n", "<leader>ts", function() nt.summary.toggle() end, { desc = "Alternar painel de testes" })
map("n", "<leader>to", function() nt.output.open({ enter = true }) end, { desc = "Mostrar resultado do teste" })
