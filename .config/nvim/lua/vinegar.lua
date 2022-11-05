vim.g.netrw_banner  = 0
vim.g.netrw_altfile = 1
vim.g.netrw_dirhistmax = 0
vim.g.netrw_list_hide  = '^\\./\\?$'

local function up()
  local file = vim.api.nvim_buf_get_name(0)
  local parent = vim.fs.dirname(file)

  vim.cmd.edit(parent)
end

local function cmd(cmd, arg)
  return function()
    vim.cmd[cmd](arg)
  end
end

vim.keymap.set('n', '-', up)
vim.keymap.set('n', '<BS>', cmd('Lexplore', '10'))
