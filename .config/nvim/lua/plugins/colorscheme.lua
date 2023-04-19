return {
  {
    'Mofiqul/dracula.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      vim.cmd('set termguicolors')

      local dracula = require("dracula")
      local colors = dracula.colors()
      dracula.setup({
        -- use transparent background
        transparent_bg = true,

        italic_comment = true,

        overrides = {
          StartifyBracket = { fg = colors.fg,                  },
          StartifyFile    = { fg = colors.fg,                  },
          StartifyFooter  = { fg = colors.green,  bold = true, },
          StartifyHeader  = { fg = colors.green,  bold = true, },
          StartifyNumber  = { fg = colors.purple,              },
          StartifyPath    = { fg = colors.purple, bold = true, },
          StartifySection = { fg = colors.pink,                },
          StartifySelect  = { fg = colors.green,  bold = true, },
          StartifySlash   = { fg = colors.fg,                  },
          StartifySpecial = { fg = colors.comment,             },
        },
      })
      vim.cmd('colorscheme dracula')

      local highlight_groups = {
        'Normal', 'NormalFloat', 'FloatBorder',
      }

      for _, highlight in pairs(highlight_groups) do
        vim.api.nvim_set_hl(0, highlight, { bg = 'none', ctermbg = 'none' })
      end
    end,
  },
}
