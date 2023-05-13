return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      defaults = {
        sorting_strategy = 'ascending',
        layout_strategy = 'center',
        layout_config = {
          horizontal = {
            prompt_position = 'top',
          },
        },
        preview = false,
      },
      pickers = {
        help_tags = {
          layout_strategy = 'horizontal',
          preview = true,
        },
      },
    },
    config = function(_, opts)
      local function map(mode, key, func, desc)
        vim.keymap.set(mode, key, func, {
          noremap = true,
          silent = true,
          desc = desc,
        })
      end

      require('telescope').setup(opts)
      local builtins = require('telescope.builtin')

      map('n', '<leader><leader>b', builtins.buffers, 'List buffers')
      map('n', '<leader>bl',        builtins.buffers, 'List buffers')
      map('n', '<leader><leader>f', builtins.find_files, 'List files')
      map('n', '<leader>ff',        builtins.find_files, 'List files')
      map('n', '<leader>/',         builtins.find_files, 'List files')
      map('n', '<leader><leader>g', builtins.live_grep, 'File search')
      map('n', '<leader>fg',        builtins.live_grep, 'File search')
      map('n', '<F1>',              builtins.help_tags, 'Vim help')
    end,
  },
}
