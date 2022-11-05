return function()
  local reload = function()
    require('plugins')
    pcall(vim.cmd.PackerCompile)
  end


  -- Compile config after it has been written to disk.
  vim.api.nvim_create_autocmd('BufWritePost', {
    pattern  = '~/.config/nvim/lua/plugins.lua',
    callback = reload,
    desc     = 'Compile packer config on write',
  })
end
