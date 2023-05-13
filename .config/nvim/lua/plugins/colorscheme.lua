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
          Normal          = {                     bg = 'none', },
          NormalFloat     = {                     bg = 'none', },
          FloatBorder     = { fg = colors.purple, bg = 'none', },

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

          TelescopeNormal        = { fg = colors.fg, bg = 'none', },
          TelescopeBorder        = { link =     'FloatBorder' },
          TelescopeResultsBorder = { link = 'TelescopeBorder' },
          TelescopePreviewBorder = { link = 'TelescopeBorder' },
          TelescopePromptBorder  = { link = 'TelescopeBorder' },
          TelescopeTitle         = { link =           'Title' },
        },
      })
      vim.cmd('colorscheme dracula')
    end,
  },
}
