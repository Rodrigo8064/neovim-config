vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Buscar arquivos" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Buscar no conteúdo" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Listar buffers" })
