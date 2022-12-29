local util = require('util')

return function()
  local treesitter = require('nvim-treesitter.configs')

  local dracula = function(color)
    return vim.g['dracula#palette'][color][1]
  end

  vim.api.nvim_create_autocmd('InsertLeave', {
    pattern  = '*',
    callback = function()
      vim.cmd('TSDisable rainbow')
      vim.cmd('TSEnable rainbow')
    end,
  })

  treesitter.setup({
    highlight = {
      enable = true,

      -- Required for spellcheck, some LaTeX highlights and code block
      -- highlights that do not have ts grammar.
      additional_vim_regex_highlighting = {'org', 'markdown'},
    },

    rainbow = {
      enable = true,
      -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
      extended_mode = true,
      -- Do not enable for files with more than n lines, int
      max_file_lines = nil,

      colors = {
        dracula('red'),
        dracula('yellow'),
        dracula('cyan'),
        dracula('green'),
        dracula('orange'),
        dracula('pink'),
        dracula('purple'),
      },

    },

    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          -- You can optionally set descriptions to the mappings (used in the desc parameter of
          -- nvim_buf_set_keymap) which plugins like which-key display
          ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },

          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
        },
        -- You can choose the select mode (default is charwise 'v')
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * method: eg 'v' or 'o'
        -- and should return the mode ('v', 'V', or '<c-v>') or a table
        -- mapping query_strings to modes.
        selection_modes = {
          ['@parameter.outer'] = 'v', -- charwise
          ['@function.outer']  = 'V', -- linewise
          ['@class.outer']     = 'V', -- blockwise
        },
        -- If you set this to `true` (default is `false`) then any textobject is
        -- extended to include preceding or succeeding whitespace. Succeeding
        -- whitespace has priority in order to act similarly to eg the built-in
        -- `ap`.
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * selection_mode: eg 'v'
        -- and should return true of false
        include_surrounding_whitespace = false,
      },
    },

  })

  vim.opt.foldmethod = 'expr'
  vim.opt.foldexpr   = 'nvim_treesitter#foldexpr()'

end
