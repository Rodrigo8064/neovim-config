vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(args)
    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = args.buf, desc = desc })
    end

    map("gd", vim.lsp.buf.definition, "Ir para definição")
    map("K", vim.lsp.buf.hover, "Documentação")
    map("<leader>rn", vim.lsp.buf.rename, "Renomear")
    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("<leader>d", vim.diagnostic.open_float, "Mostrar mensagem de erro")
    -- referências: use o default `grr`

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method("textDocument/documentHighlight", args.buf) then
      local group = vim.api.nvim_create_augroup("lsp-highlight-" .. args.buf, { clear = true })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = args.buf, group = group, callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = args.buf, group = group, callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

require('mason').setup {
  ui = {
    icons = {
      package_installed = '✓',
      package_uninstalled = '✗',
      package_pending = '⟳',
    },
  },
}
