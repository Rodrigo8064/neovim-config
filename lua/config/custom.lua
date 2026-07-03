local api = vim.api
-- remove trailing whitespace on save
api.nvim_create_autocmd('BufWritePre', {
  group = api.nvim_create_augroup('trim-whitespace', { clear = true }),
  callback = function(args)
    if not vim.bo[args.buf].modifiable or vim.bo[args.buf].buftype ~= '' then
      return
    end
    local cursor = api.nvim_win_get_cursor(0)
    local lines = api.nvim_buf_get_lines(args.buf, 0, -1, false)
    local changed = false
    for i, line in ipairs(lines) do
      local stripped = line:gsub('%s+$', '')
      if stripped ~= line then
        lines[i] = stripped
        changed = true
      end
    end
    if changed then
      api.nvim_buf_set_lines(args.buf, 0, -1, false, lines)
    end
    api.nvim_win_set_cursor(0, cursor)
  end,
})

-- highlight on yank
api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
