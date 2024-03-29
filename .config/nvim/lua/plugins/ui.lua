return {
  {
    'nvim-lualine/lualine.nvim',
    opts = {},
  },
  {
    'folke/which-key.nvim',
    opts = {
      plugins = {
        marks = false,
        registers = false,
      },
      window = {
        border = 'single',
      },
      layout = {
        height = { min = 1, },
        spacing = 2,
        align = 'center',
      },
    },
    config = function(_, opts)
      vim.o.timeout    = true
      vim.o.timeoutlen = 300
      local which_key = require('which-key')
      which_key.setup(opts)
      which_key.register({
        ['<leader>l']  = {
          name  = '+lsp',
          g = { name = '+goto', },
        },
        ['<leader>b']  = {
          name  = '+buffer',
        },
        ['<leader>f']  = {
          name  = '+files',
        },
        ['<leader><leader>']  = {
          name  = '+quick-action',
        },
      })
    end,
  },

  {
    'mhinz/vim-startify',
    config = function()
      vim.g.startify_lists = {
        { ['type'] = 'bookmarks', headers = '   Bookmarks' },
        { ['type'] = 'commands',  headers = '   Commands'  },
      }

      vim.g.startify_bookmarks = {
        { n = '~/.config/nvim/init.lua'    },
        { x = '~/.config/xmonad/xmonad.hs' },
      }
      vim.g.startify_fortune_use_unicode = 1
      vim.g.startify_change_to_vcs_root  = 1

      vim.g.startify_custom_header_quotes = vim.fn['startify#fortune#predefined_quotes']()

    end,
  },

  {
    'nvim-tree/nvim-web-devicons',
    lazy = true
  },
  {
    'ten3roberts/qf.nvim',
    opts = {
      c = {
        max_height = 10,
        min_height = 0,
      },
      l = {
        max_height = 10,
        min_height = 0,
      },
      pretty = false,
    },
    config = function(_, opts)
      local qf = require('qf')
      qf.setup(opts)

      vim.keymap.set('n', '<leader>q', function() qf.toggle('c', true) end, { noremap = true, desc = 'Toggle quickfix', })
      vim.keymap.set('n', ']q', '<cmd>cnext<cr>',     { noremap = true, desc = 'Next quickfix item', })
      vim.keymap.set('n', '[q', '<cmd>cprevious<cr>', { noremap = true, desc = 'Previous quickfix item', })
    end,
  },
  {
    'mbbill/undotree',
    config = function()

      -- Do not highlight cursor line on undotree buffer
      vim.g.undotree_CursorLine = 0

      -- Style 3
      -- +------------------------+----------+
      -- |                        |          |
      -- |                        |          |
      -- |                        | undotree |
      -- |                        |          |
      -- |                        |          |
      -- |                        +----------+
      -- |                        |          |
      -- |                        |   diff   |
      -- |                        |          |
      -- +------------------------+----------+
      vim.g.undotree_WindowLayout = 3


      if vim.fn.has('persistent_undo') then
        vim.o.undofile = true
      end

      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { noremap = true, silent = true, desc = 'Undo tree' })
      vim.keymap.set('n', 'U', vim.cmd.UndotreeToggle, { noremap = true, silent = true, desc = 'Undo tree' })
    end,
  },
}
