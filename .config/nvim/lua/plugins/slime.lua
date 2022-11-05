return function()
  vim.g.slime_paste_file = vim.env.XDG_RUNTIME_DIR .. '/.slime_paste'

  vim.g.slime_target = 'tmux'
  vim.g.slime_default_config = {
    socket_name = string.gsub(vim.env['TMUX'], ",.*", ""),
    target_pane = '{last}',
  }
end
