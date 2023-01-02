local util = require('util')

local options = {
  number         = false,
  relativenumber = false,
  termguicolors  = true,

  foldlevel      = 9999,

  -- Sane split direction
  splitbelow     = true,
  splitright     = true,
}

util.vim.opt(options)

vim.g.mapleader = ' '
vim.g.netrw_dirhistmax = 0

if vim.loop.getuid() == 0 then
  return
end

require('plugins')

vim.cmd.colorscheme('dracula')

local telescope = {
  builtin = require('telescope.builtin'),
  project = require('telescope').extensions.project.project,
}

vim.keymap.set('n', '<Leader>ff', telescope.builtin.find_files)
vim.keymap.set('n', '<Leader>fg', telescope.builtin.live_grep)
vim.keymap.set('n', '<Leader>g', telescope.builtin.git_files)
vim.keymap.set('n', '<Leader>p', telescope.project)
vim.keymap.set('n', '<Leader>b', telescope.builtin.buffers)
vim.keymap.set('n', 'gO', telescope.builtin.treesitter)

vim.api.nvim_create_autocmd('Filetype', {
  pattern  = 'netrw,startify',
  callback = function()
    vim.keymap.set('n', '/', telescope.builtin.find_files, { buffer = true })
  end,
})

vim.api.nvim_create_autocmd('BufRead', {
  pattern  = '/tmp/bash-fc.*',
  callback = function()
    vim.opt.filetype = 'bash'
  end,
})


local transpaency = true

if transpaency then
  local highlight_groups = {
    'Normal', 'NormalFloat',
  }

  for _, highlight in pairs(highlight_groups) do
    vim.api.nvim_set_hl(0, highlight, { bg = 'none', ctermbg = 'none' })
  end
end

require('lsp')
