-- Hook de build: precisa ser registrado ANTES de qualquer vim.pack.add
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
      if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
      vim.cmd("TSUpdate")
    end
  end,
})

-- A ordem importa em um caso: o tema vem antes do lualine
local modules = {
  "colorscheme",
  "lualine",
  "telescope",
  "neo-tree",
  "treesitter",
  "treesitter-textobjects",
  "mason",
  "completion",
  "conform",
  "gitsigns",
  "autopairs",
  "markdown",
  "neotest",
  "toggleterm",
}

for _, m in ipairs(modules) do
  local ok, err = pcall(require, "plugins." .. m)
  if not ok then
    vim.notify("Erro em plugins." .. m .. ":\n" .. err, vim.log.levels.ERROR)
  end
end
