vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
})

require("telescope").setup({
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
})

-- pcall: se o make falhar, o Telescope continua funcionando com o sorter padrão
pcall(require("telescope").load_extension, "fzf")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Buscar arquivos" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Buscar no conteúdo" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Listar buffers" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
