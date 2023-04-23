return {
  {
    'nvim-lualine/lualine.nvim',
    opts = {},
  },
  {
    'folke/which-key.nvim',
    opts = {
      window = {
        border = 'single',
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
}
