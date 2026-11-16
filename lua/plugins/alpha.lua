vim.pack.add({
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/goolord/alpha-nvim",
})

local dashboard = require("alpha.themes.dashboard")
local root = vim.fn.expand("~/projetos")

local function icon(code) return vim.fn.nr2char(code) .. "  " end

-- Cores do catppuccin (reaplicadas se o colorscheme for recarregado)
local function set_hl()
  local ok, palettes = pcall(require, "catppuccin.palettes")
  if not ok then return end
  local p = palettes.get_palette("mocha")
  vim.api.nvim_set_hl(0, "AlphaHeader", { fg = p.mauve })
  vim.api.nvim_set_hl(0, "AlphaTitle", { fg = p.lavender, bold = true })
  vim.api.nvim_set_hl(0, "AlphaButtons", { fg = p.text })
  vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = p.peach, bold = true })
  vim.api.nvim_set_hl(0, "AlphaFooter", { fg = p.overlay1, italic = true })
end
set_hl()
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_hl })

local function style(b)
  b.opts.hl = "AlphaButtons"
  b.opts.hl_shortcut = "AlphaShortcut"
  return b
end

local function title(text)
  return { type = "text", val = text, opts = { position = "center", hl = "AlphaTitle" } }
end

-- Projetos: recentes primeiro, depois o resto em ordem alfabética
local function list_projects()
  if vim.fn.isdirectory(root) == 0 then return {} end

  local all = vim.fn.readdir(root, function(name)
    return (name:sub(1, 1) ~= "." and vim.fn.isdirectory(root .. "/" .. name) == 1) and 1 or 0
  end)
  local exists = {}
  for _, n in ipairs(all) do exists[n] = true end

  local ordered, seen = {}, {}
  local prefix = "^" .. vim.pesc(root) .. "/([^/]+)/"
  for _, f in ipairs(vim.v.oldfiles) do
    local name = f:match(prefix)
    if name and exists[name] and not seen[name] then
      seen[name] = true
      table.insert(ordered, name)
    end
  end
  for _, n in ipairs(all) do
    if not seen[n] then table.insert(ordered, n) end
  end
  return ordered
end

local function open_project(name)
  vim.cmd.cd(vim.fn.fnameescape(root .. "/" .. name))
  require("telescope.builtin").find_files()
end

-- Seletor com todos os projetos (:Projects, <leader>fp ou botão "p")
vim.api.nvim_create_user_command("Projects", function()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local state = require("telescope.actions.state")

  pickers.new({}, {
    prompt_title = "Projetos",
    finder = finders.new_table({ results = list_projects() }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(bufnr)
      actions.select_default:replace(function()
        local sel = state.get_selected_entry()
        actions.close(bufnr)
        if sel then open_project(sel[1]) end
      end)
      return true
    end,
  }):find()
end, {})

vim.keymap.set("n", "<leader>fp", "<cmd>Projects<CR>", { desc = "Projetos" })

-- Header
dashboard.section.header.val = {
  "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
  "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
  "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
  "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
  "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
  "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
}
dashboard.section.header.opts.hl = "AlphaHeader"

-- Botões de projeto: val como função, recalculado a cada desenho do dashboard
-- (vim.v.oldfiles só é preenchido depois do init.lua)
local project_buttons = {
  type = "group",
  opts = { spacing = 1 },
  val = function()
    local btns = {}
    for i, name in ipairs(list_projects()) do
      if i > 5 then break end
      table.insert(btns, style(dashboard.button(
        tostring(i),
        icon(0xf07b) .. name,
        "<cmd>cd " .. vim.fn.fnameescape(root .. "/" .. name) .. " | Telescope find_files<CR>"
      )))
    end
    table.insert(btns, style(dashboard.button("p", icon(0xf002) .. "Todos os projetos", "<cmd>Projects<CR>")))
    return btns
  end,
}

-- Botões gerais
dashboard.section.buttons.val = {
  dashboard.button("e",       icon(0xf016) .. "Novo arquivo",       "<cmd>enew<CR>"),
  dashboard.button("SPC f f", icon(0xf002) .. "Buscar arquivos",    "<cmd>Telescope find_files<CR>"),
  dashboard.button("SPC f g", icon(0xf15c) .. "Buscar no conteúdo", "<cmd>Telescope live_grep<CR>"),
  dashboard.button("r",       icon(0xf1da) .. "Arquivos recentes",  "<cmd>Telescope oldfiles<CR>"),
  dashboard.button("SPC e",   icon(0xf07b) .. "File tree",          "<cmd>Neotree toggle<CR>"),
  dashboard.button("c",       icon(0xf013) .. "Configuração",
    "<cmd>cd " .. vim.fn.stdpath("config") .. " | edit init.lua<CR>"),
  dashboard.button("u",       icon(0xf021) .. "Atualizar plugins",  "<cmd>lua vim.pack.update()<CR>"),
  dashboard.button("q",       icon(0xf011) .. "Sair",               "<cmd>qa<CR>"),
}
for _, b in ipairs(dashboard.section.buttons.val) do style(b) end

dashboard.section.footer.val = #vim.pack.get(nil, { info = false }) .. " plugins"
dashboard.section.footer.opts.hl = "AlphaFooter"

dashboard.config.layout = {
  { type = "padding", val = 2 },
  dashboard.section.header,
  { type = "padding", val = 2 },
  title("Projetos"),
  { type = "padding", val = 1 },
  project_buttons,
  { type = "padding", val = 2 },
  title("Geral"),
  { type = "padding", val = 1 },
  dashboard.section.buttons,
  { type = "padding", val = 1 },
  dashboard.section.footer,
}

require("alpha").setup(dashboard.config)

vim.keymap.set("n", "<leader>a", "<cmd>Alpha<CR>", { desc = "Dashboard" })
