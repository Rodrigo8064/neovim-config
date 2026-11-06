vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
})

local ensure_installed = {
  "bash", "diff", "dockerfile", "html", "javascript",
  "json", "lua", "make", "markdown", "markdown_inline",
  "python", "regex", "toml", "tsx", "typescript",
  "vim", "vimdoc", "yaml",
}

local already_installed = require("nvim-treesitter.config").get_installed()
local parsers_to_install = vim.iter(ensure_installed)
  :filter(function(parser) return not vim.tbl_contains(already_installed, parser) end)
  :totable()

if #parsers_to_install > 0 then
  require("nvim-treesitter").install(parsers_to_install)
end

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
    if not lang then return end
    local ok, loaded = pcall(vim.treesitter.language.add, lang)
    if ok and loaded then
      vim.treesitter.start(args.buf, lang)
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

require("treesitter-context").setup({})
