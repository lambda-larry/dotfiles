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
}
