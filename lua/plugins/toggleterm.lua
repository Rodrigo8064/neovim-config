-- Terminal
vim.pack.add { 'https://github.com/akinsho/toggleterm.nvim' }

require('toggleterm').setup {
  direction = 'float',
  float_opts = { border = 'curved' },
  open_mapping = [[<c-\>]],
}
