return {
  init_options = {
    settings = { organizeImports = true, lineLength = 79, fixAll = true },
  },
  on_attach = function(client)
    client.server_capabilities.hoverProvider = false
  end,
}
