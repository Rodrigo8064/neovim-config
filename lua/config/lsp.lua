local capabilities = vim.lsp.protocol.make_client_capabilities()

-- O jeito atual e limpo:
vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
  local default_config = { border = "rounded" }
  return vim.lsp.handlers.hover(err, result, ctx, vim.tbl_deep_extend("force", default_config, config or {}))
end

vim.lsp.handlers["textDocument/signatureHelp"] = function(err, result, ctx, config)
  local default_config = { border = "rounded" }
  return vim.lsp.handlers.signatureHelp(err, result, ctx, vim.tbl_deep_extend("force", default_config, config or {}))
end


local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
  capabilities = cmp_lsp.default_capabilities(capabilities)
end

vim.lsp.config("zubanls", {
  capabilities = capabilities,
  name = "ZubanLS",
  cmd = { "zuban", "server" },
  root_markers = { "pyproject.toml", ".git" },
  filetypes = { "python" },
})

vim.lsp.config("ruff", {
  capabilities = capabilities,
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  init_options = {
    settings = {
      organizeImports = true,
    },
  },
  on_attach = function(client, _)
    client.server_capabilities.hoverProvider = false
  end,
})

vim.lsp.config("jsonls", {
  capabilities = capabilities,
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
})

vim.lsp.config("yamlls", {
  capabilities = capabilities,
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml", "yml" },
})

vim.lsp.config("marksman", {
  capabilities = capabilities,
  cmd = { "marksman", "server" },
  filetypes = { "markdown" },
})

vim.lsp.enable({ "zubanls", "ruff", "jsonls", "yamlls", "marksman" })

-- Autoformat + organize imports ao salvar
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function()
    -- Organiza imports via code action
    vim.lsp.buf.code_action({
      context = {
        only = { "source.organizeImports" },
      },
      apply = true,
    })
    -- Formata o arquivo
    vim.lsp.buf.format({
      async = false,
      filter = function(client)
        return client.name == "ruff"
      end,
    })
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local map = vim.keymap.set
    local opts = { buffer = args.buf }
    map("n", "gd",         vim.lsp.buf.definition,  vim.tbl_extend("force", opts, { desc = "Ir para definição" }))
    map("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, vim.tbl_extend("force", opts, { desc = "Documentação" }))
    map("n", "<leader>rn", vim.lsp.buf.rename,       vim.tbl_extend("force", opts, { desc = "Renomear" }))
    map("n", "<leader>ca", vim.lsp.buf.code_action,  vim.tbl_extend("force", opts, { desc = "Code action" }))
    map("n", "gr",         vim.lsp.buf.references,   vim.tbl_extend("force", opts, { desc = "Referências" }))
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.supports_method("textDocument/documentHighlight") then
      local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false }) 
      -- Destaca a palavra quando o cursor para em cima
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = args.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })
      -- Limpa o destaque quando o cursor se move
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = args.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})
