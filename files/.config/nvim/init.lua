vim.g.loaded_gtags = 1
vim.g.loaded_gtags_cscope = 1

local leader = ' '

vim.g.mapleader = leader
vim.opt.guicursor = {
  -- Insert mode use beem cursor.
  'i-ci-ve:ver25',
  -- Normal mode use bar cursor.
  'n-v-c-sm:hor20',
  -- Replace mode use cursor.
  'r-cr-o:block',
  -- All modes blink the cursor.
  'a:blinkon250-blinkoff250',
}

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.completeopt:remove('preview')


if vim.fn.executable('rg') then
  vim.opt.grepprg    = 'rg --vimgrep'
  vim.opt.grepformat = '%f:%l:%c:%m'
end

vim.g.compiler_gcc_ignore_unmatched_lines = 1

vim.diagnostic.config({
  underline        = true,
  virtual_text     = true,
  signs            = false,
  floats           = false,
  update_in_insert = false,
})

vim.opt.exrc = true


if vim.fn.executable('column') then
  vim.keymap.set('v', '<tab>', "!column -t -o ' '<cr>gv=gv", { noremap = false })
end
vim.keymap.set('v', '.', ':normal .<cr>')

local function open_todo()
  local buf = vim.fn.bufadd('TODO.md')
  if 0 == buf then
    return
  end

  local win = vim.api.nvim_open_win(buf, false, {
    relative = 'editor',
    row      = math.floor(vim.go.lines   / 4),
    col      = math.floor(vim.go.columns / 4),
    width    = math.floor(vim.go.columns / 2),
    height   = math.floor(vim.go.lines   / 2),
    border   = 'single',
  })
  vim.keymap.set('n', 'q', '<cmd>wq!<cr>', { buffer = buf });
  vim.keymap.set('n', '<leader>t', '<cmd>wq!<cr>', { buffer = buf });

  vim.api.nvim_set_current_win(win)
end
vim.keymap.set('n', '<leader>t', open_todo);

vim.cmd 'packadd nohlsearch'
vim.cmd 'packadd nvim.undotree'

vim.keymap.set('n', 'U', '<cmd>Undotree<cr>')

if vim.fn.has('persistent_undo') then
  vim.o.undofile = true
end

vim.keymap.set('n', '<leader>w', '<cmd>w<cr>')


vim.cmd 'autocmd TextYankPost * silent! lua vim.hl.on_yank {higroup="Search", timeout=300}'









vim.g.termdebug_config = {
    wide = 160,

    map_minus = 0,
    map_plus  = 0,
    map_K     = 0,

    variables_window = 1,
}

vim.cmd [[

function! s:TermdebugBinding(create)
    if a:create
        nnoremap <silent> <F2>  <cmd>ToggleBreak<CR>
        nnoremap <silent> <F3>  <cmd>Tbreak<CR>
        nnoremap <silent> <F5>  <cmd>Run<CR>
        nnoremap <silent> <F6>  <cmd>Continue<CR>
        nnoremap <silent> <F7>  <cmd>Step<CR>
        nnoremap <silent> <F8>  <cmd>Over<CR>
        nnoremap <silent> <F9>  <cmd>Finish<CR>
        nnoremap <silent> <F10> <cmd>Stop<CR>
        nnoremap <silent> <F11> <cmd>Until<CR>
    else
        nunmap <F2>
        nunmap <F3>
        nunmap <F5>
        nunmap <F6>
        nunmap <F7>
        nunmap <F8>
        nunmap <F9>
        nunmap <F10>
        nunmap <F11>
    endif
endfunction

autocmd User TermdebugStartPost call s:TermdebugBinding(v:true)
autocmd User TermdebugStopPost  call s:TermdebugBinding(v:false)

]]


vim.cmd [[

augroup sensitive
  autocmd!

  autocmd BufNewFile,BufRead /tmp/* setlocal noundofile
  autocmd BufNewFile,BufRead /**/doctl/config.yaml setlocal noundofile

augroup END
]]

vim.cmd [[
autocmd BufNewFile,BufRead */.ssh/known_hosts   setlocal filetype=sshconfig
autocmd BufNewFile,BufRead */.ssh/known_hosts.* setlocal filetype=sshconfig
]]

vim.cmd [[
autocmd BufNewFile,BufRead kea-dhcp[46].conf  setlocal filetype=json5
autocmd BufNewFile,BufRead kea-dhcp-ddns.conf setlocal filetype=json5
]]


vim.pack.add({
  { src = 'https://github.com/lambda-larry/tmux-termdebug', },
  {
    src = 'https://github.com/tpope/vim-repeat',
  },
  {
    src = 'https://github.com/tpope/vim-surround',
  },
  {
    src = 'https://github.com/lambda-larry/vim-vinegar.nvim',
  },
  {
    src = 'https://github.com/Mofiqul/dracula.nvim',
    data = {
      config = function(spec)
      vim.cmd('set termguicolors')

      local dracula = require("dracula")
      local colors = dracula.colors()
      dracula.setup({
        -- use transparent background
        transparent_bg = true,

        italic_comment = false,

        overrides = {
          Normal          = {                     bg = 'none', },
          NormalFloat     = {                     bg = 'none', },
          FloatBorder     = { fg = colors.purple, bg = 'none', },
          TabLine         = { fg = colors.pink,   bg = colors.selection, },
          TabLineFill     = {                     bg = colors.selection, },
          TabLineSel      = { fg = colors.purple, bg = colors.selection, },

          Search          = { fg = colors.yellow, bg = 'none', underline = true, },
          CurSearch       = { fg = colors.yellow, bg = 'none', underline = true, },
          IncSearch       = { fg = colors.yellow, bg = 'none', underline = true, },

          CursorLine      = {                     bg = colors.bg, },

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

          markdownH1 = { fg = colors.pink,   bold = true, },
          markdownH2 = { fg = colors.orange, bold = true, },
          markdownH3 = { fg = colors.purple, bold = true, },
          markdownH4 = { fg = colors.pink,   bold = true, },
          markdownH5 = { fg = colors.orange, bold = true, },
          markdownH6 = { fg = colors.purple, bold = true, },

          htmlH1 = { fg = colors.pink,   },
          htmlH2 = { fg = colors.orange, },
          htmlH3 = { fg = colors.purple, },
          htmlH4 = { fg = colors.pink,   },
          htmlH5 = { fg = colors.orange, },
          htmlH6 = { fg = colors.purple, },

          ['@tag'] = { link = '@keyword' },

          ['@markup.heading.1.markdown'] = { fg = colors.pink,   bold = true, },
          ['@markup.heading.2.markdown'] = { fg = colors.orange, bold = true, },
          ['@markup.heading.3.markdown'] = { fg = colors.purple, bold = true, },
          ['@markup.heading.4.markdown'] = { fg = colors.pink,   bold = true, },
          ['@markup.heading.5.markdown'] = { fg = colors.orange, bold = true, },
          ['@markup.heading.6.markdown'] = { fg = colors.purple, bold = true, },

          ['@org.headline.level1'] = { link = 'markdownH1' },
          ['@org.headline.level2'] = { link = 'markdownH2' },
          ['@org.headline.level3'] = { link = 'markdownH3' },
          ['@org.headline.level4'] = { link = 'markdownH4' },
          ['@org.headline.level5'] = { link = 'markdownH5' },
          ['@org.headline.level6'] = { link = 'markdownH6' },
          ['@org.headline.level7'] = { link = 'markdownH1' },
          ['@org.headline.level8'] = { link = 'markdownH2' },

          ['@org.block.content'] = { link = 'markdownBlockquote' },

          -- TS rainbow colors
          rainbowcol1 = { fg = colors.pink        },
          rainbowcol2 = { fg = colors.purple      },
          rainbowcol3 = { fg = colors.orange      },
          rainbowcol4 = { fg = colors.yellow      },
          rainbowcol5 = { fg = colors.bright_cyan },
          rainbowcol6 = { fg = colors.cyan        },
          rainbowcol7 = { fg = colors.green       },

          -- Rainbow delimiter
          RainbowDelimiterRed    = { link = 'rainbowcol1' },
          RainbowDelimiterYellow = { link = 'rainbowcol2' },
          RainbowDelimiterBlue   = { link = 'rainbowcol3' },
          RainbowDelimiterOrange = { link = 'rainbowcol4' },
          RainbowDelimiterGreen  = { link = 'rainbowcol5' },
          RainbowDelimiterViolet = { link = 'rainbowcol6' },
          RainbowDelimiterCyan   = { link = 'rainbowcol7' },

        },
      })
      vim.cmd('colorscheme dracula')
      end,
    },
  },
  {
    src = 'https://github.com/alexghergh/nvim-tmux-navigation',
    data = {
      config = function(spec)
        local nvim_tmux_nav = require('nvim-tmux-navigation')

        nvim_tmux_nav.setup {
          disable_when_zoomed = true -- defaults to false
        }

        vim.keymap.set('n', '<C-h>', nvim_tmux_nav.NvimTmuxNavigateLeft)
        vim.keymap.set('n', '<C-j>', nvim_tmux_nav.NvimTmuxNavigateDown)
        vim.keymap.set('n', '<C-k>', nvim_tmux_nav.NvimTmuxNavigateUp)
        vim.keymap.set('n', '<C-l>', nvim_tmux_nav.NvimTmuxNavigateRight)

        vim.keymap.set('t', '<C-h>', nvim_tmux_nav.NvimTmuxNavigateLeft)
        vim.keymap.set('t', '<C-j>', nvim_tmux_nav.NvimTmuxNavigateDown)
        vim.keymap.set('t', '<C-k>', nvim_tmux_nav.NvimTmuxNavigateUp)
        vim.keymap.set('t', '<C-l>', nvim_tmux_nav.NvimTmuxNavigateRight)
        vim.keymap.set('t', '<C-q><C-l>', '<C-l>')
      end,
    },
  },
  {
    src = 'https://github.com/stevearc/dressing.nvim',
    data = {
      config = function(spec)
        require('dressing').setup({
          input = {
            border = 'rounded',
          },
        })
      end,
    },
  },
  {
    src = 'https://github.com/nvim-lualine/lualine.nvim',
    data = {
      config = function(spec)
        if true then
          require('lualine').setup({
            options = {
              disabled_filetypes = {
                statusline = {},
                winbar = {},
              },
            },
            tabline = {
              lualine_a = { 'filename' },
              lualine_b = { 'tabs' },
              lualine_c = { 'windows' },
              lualine_x = {},
              lualine_y = {},
              lualine_z = { 'buffers' },
            },
          })
        else

          vim.opt.statusline = table.concat({
            "Statusline left-aligned stuff",
            "%=", -- Left/right separator
            "Statusline right-aligned stuff",
          })

        end
      end,
    },
  },
  {
    src = 'https://github.com/mhinz/vim-startify',
    data = {
      config = function(spec)
        vim.g.startify_lists                = {
          { ['type'] = 'commands',  headers = '   Commands' },
          { ['type'] = 'bookmarks', headers = '   Bookmarks' },
        }

        vim.g.startify_bookmarks            = {
          { n = '~/.config/nvim/init.lua' },
        }
        vim.g.startify_commands             = {
          { t = { 'Task',          'Tw'         }, },
          { c = { 'Task Calendar', 'TwCalendar' }, },
        }
        vim.g.startify_fortune_use_unicode  = 1
        vim.g.startify_change_to_vcs_root   = 1

        vim.g.startify_custom_header_quotes = vim.fn['startify#fortune#predefined_quotes']()
      end,
    },
  },
  {
    src = 'https://github.com/rcarriga/nvim-notify',
    data = {
      config = function(spec)
        vim.notify = require("notify")
        vim.notify.setup(
          {
            background_colour = "#000000",
            fps = 60,
            icons = {
              DEBUG = "",
              ERROR = "",
              INFO = "",
              TRACE = "✎",
              WARN = ""
            },
            level = 2,
            minimum_width = 50,
            render = "default",
            stages = "fade_in_slide_out",
            time_formats = {
              notification = "%T",
              notification_history = "%FT%T"
            },
            timeout = 5000,
            top_down = true
          }
        )
      end
    },
  },
  {
    src = 'https://github.com/jpalardy/vim-slime',
    data = {
      config = function(spec)
        vim.g.slime_paste_file = vim.fn.stdpath('run') .. '/.slime_paste'

        vim.g.slime_target = 'neovim'

        if vim.env['TMUX'] then
          vim.g.slime_target = 'tmux'
          vim.g.slime_default_config = {
            socket_name = string.gsub(vim.env['TMUX'], ',.*', ''),
            target_pane = '{last}',
          }
        end
      end,
    },
  },
  {
    src = 'https://github.com/lambda-larry/qbe.vim',
  },
  {
    src = 'https://github.com/nvim-lua/plenary.nvim',
  },
  {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    version = 'main',
    data = {
      hook = function(ev)
        local kind = ev.data.kind

        if 'install' == kind or 'update' == kind then
          vim.cmd('TSUpdate')
        end

      end,
      config = function(spec)
        local nvim_treesitter = require('nvim-treesitter')
        vim.api.nvim_create_autocmd('FileType', {
          pattern = vim.list_extend(
            {'sh'},
            nvim_treesitter.get_installed()
          ),
          callback = function()
            vim.treesitter.start()
            vim.wo.foldlevel  = 999
            vim.wo.foldmethod = 'expr'
            vim.wo.foldexpr   = 'v:lua.vim.treesitter.foldexpr()'
          end,
        })
      end,
    },
  },
  {
    src = 'https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git',
    data = {
      config = function(spec)
        vim.g.rainbow_delimiters = {
          strategy = {
            [''] = 'rainbow-delimiters.strategy.global',
            vim  = 'rainbow-delimiters.strategy.local',
          },
          query = {
            [''] = 'rainbow-delimiters',
            lua  = 'rainbow-blocks',
          },
          priority = {
            [''] = 110,
            lua  = 210,
          },
          highlight = {
            'RainbowDelimiterRed',
            'RainbowDelimiterYellow',
            'RainbowDelimiterBlue',
            'RainbowDelimiterOrange',
            'RainbowDelimiterGreen',
            'RainbowDelimiterViolet',
            'RainbowDelimiterCyan',
          },
        }
      end,
    },
  },
  {
    src = 'https://github.com/nvim-telescope/telescope.nvim',
    version = vim.version.range('v0.2.x'),
    data = {
      config = function(spec)
        require('telescope').setup({
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
              preview = {
                treesitter = {
                  enable = {
                    'vimdoc',
                  },
                },
              }
            },
            git_status = {
              layout_strategy = 'horizontal',
              preview = true,
            },
            git_bcommits = {
              layout_strategy = 'horizontal',
              preview = true,
            },
            git_commits = {
              layout_strategy = 'horizontal',
              preview = true,
            },
          },
        })

        local builtins = require('telescope.builtin')

        vim.keymap.set('n', '<F1>',      builtins.help_tags,     { noremap = true, silent = true });
        vim.keymap.set('n', '<leader>f', builtins.find_files,    { noremap = true, silent = true });
        vim.keymap.set('n', '<leader>/', builtins.find_files,    { noremap = true, silent = true });
        vim.keymap.set('n', '<leader>b', builtins.buffers,       { noremap = true, silent = true });
        vim.keymap.set('n', '<leader>g', builtins.live_grep,     { noremap = true, silent = true });
        vim.keymap.set('n', '<leader>?', builtins.live_grep,     { noremap = true, silent = true });
        vim.keymap.set('n', '<leader>k', builtins.man_pages,     { noremap = true, silent = true });
        vim.keymap.set('n', '<leader>q', builtins.quickfix,      { noremap = true, silent = true });
        vim.keymap.set('n', '<leader>m', builtins.marks,         { noremap = true, silent = true });
        vim.keymap.set('n', 'z=',        builtins.spell_suggest, { noremap = true, silent = true });

      end,
    },
  },
  {
    src = 'https://github.com/MattHandzel/taskwarrior.nvim',
    data = {
      config = function(spec)
        require('taskwarrior').setup({
        })
      end,
    },
  },
  {
    src = 'https://github.com/hat0uma/csvview.nvim',
    data = {
      config = function(spec)
        require('csvview').setup({
          parser = {
            --- The number of lines that the asynchronous parser processes per cycle.
            --- This setting is used to prevent monopolization of the main thread when displaying large files.
            --- If the UI freezes, try reducing this value.
            --- @type integer
            async_chunksize = 50,

            --- Specifies the delimiter character to separate columns.
            --- This can be configured in one of three ways:
            ---
            --- 1. As a single string for a fixed delimiter.
            ---    e.g., delimiter = ","
            ---
            --- 2. As a function that dynamically returns the delimiter.
            ---    e.g., delimiter = function(bufnr) return "\t" end
            ---
            --- 3. As a table for advanced configuration:
            ---    - `ft`: Maps filetypes to specific delimiters. This has the highest priority.
            ---    - `fallbacks`: An ordered list of delimiters to try for automatic detection
            ---      when no `ft` rule matches. The plugin will test them in sequence and use
            ---      the first one that highest scores based on the number of fields in each line.
            ---
            --- Note: Only fixed-length strings are supported as delimiters.
            --- Regular expressions (e.g., `\s+`) are not currently supported.
            --- @type CsvView.Options.Parser.Delimiter
            delimiter = {
              ft = {
                csv = ",",
                tsv = "\t",
              },
              fallbacks = {
                ",",
                "\t",
                ";",
                "|",
                ":",
                " ",
              },
            },

            --- The quote character
            --- If a field is enclosed in this character, it is treated as a single field and the delimiter in it will be ignored.
            --- e.g:
            ---  quote_char= "'"
            --- You can also specify it on the command line.
            --- e.g:
            --- :CsvViewEnable quote_char='
            --- @type string
            quote_char = '"',

            --- The comment prefix characters
            --- If the line starts with one of these characters, it is treated as a comment.
            --- Comment lines are not displayed in tabular format.
            --- You can also specify it on the command line.
            --- e.g:
            --- :CsvViewEnable comment=#
            --- @type string[]
            comments = {
              -- "#",
              -- "--",
              -- "//",
            },

            --- The number of lines at the beginning of the file to treat as comments.
            --- Lines from 1 to this number will be treated as comment lines regardless of their content.
            --- This is useful for files that have a fixed header/metadata section at the top.
            --- You can also specify it on the command line.
            --- e.g:
            --- :CsvViewEnable comment_lines=2
            --- @type integer?
            comment_lines = nil,

            --- Maximum lookahead for multi-line fields
            --- This limits how many lines ahead the parser will look when trying to find
            --- the closing quote of a multi-line field. Setting this too high may cause
            --- performance issues when editing files with unmatched quotes.
            --- @type integer
            max_lookahead = 50,
          },
          view = {
            --- minimum width of a column
            --- @type integer
            min_column_width = 5,

            --- spacing between columns.
            --- A number keeps the legacy behavior of adding that many spaces after each column.
            --- A table can add virtual spaces around delimiters:
            ---   spacing = { left = 1, right = 1 }
            --- @type integer|{left:integer?, right:integer?}
            spacing = 2,

            --- The display method of the delimiter
            --- "highlight" highlights the delimiter
            --- "border" displays the delimiter with `│`
            --- You can also specify it on the command line.
            --- e.g:
            --- :CsvViewEnable display_mode=border
            ---@type CsvView.Options.View.DisplayMode
            display_mode = "highlight",

            --- The line number of the header row
            --- Controls which line should be treated as the header for the CSV table.
            --- This affects both visual styling and the sticky header feature.
            ---
            --- Values:
            --- - `true`: Automatically detect the header line (default)
            --- - `integer`: Specific line number to use as header (1-based)
            --- - `false`: No header line, treat all lines as data rows
            ---
            --- When a header is defined, it will be:
            --- - Highlighted with the CsvViewHeaderLine highlight group
            --- - Used for the sticky header feature if enabled
            --- - Excluded from normal data processing in some contexts
            ---
            --- See also: `view.sticky_header`
            --- @type integer|false|true
            header_lnum = true,

            --- The sticky header feature settings
            --- If `view.header_lnum` is set, the header line is displayed at the top of the window.
            sticky_header = {
              --- Whether to enable the sticky header feature
              --- @type boolean
              enabled = true,

              --- The separator character for the sticky header window
              --- set `false` to disable the separator
              --- @type string|false
              separator = "─",
            },
          },

          --- Keymaps for csvview.
          --- These mappings are only active when csvview is enabled.
          --- You can assign key mappings to each action defined in `opts.actions`.
          --- For example:
          --- ```lua
          --- keymaps = {
            ---   -- Text objects for selecting fields
            ---   textobject_field_inner = { "if", mode = { "o", "x" } },
            ---   textobject_field_outer = { "af", mode = { "o", "x" } },
            ---
            ---   -- Excel-like navigation:
            ---   -- Use <Tab> and <S-Tab> to move horizontally between fields.
            ---   -- Use <Enter> and <S-Enter> to move vertically between rows.
            ---   -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
            ---   jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
            ---   jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
            ---   jump_next_row = { "<Enter>", mode = { "n", "v" } },
            ---   jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
            ---
            ---   -- Custom key mapping example:
            ---   { "<leader>h", function() print("hello") end, mode = "n" },
            --- }
            --- ```
            --- @type CsvView.Options.Keymaps
            keymaps = {
              textobject_field_inner = { "if", mode = { "o", "x" } },
              textobject_field_outer = { "af", mode = { "o", "x" } },

              jump_next_field_end = { "<Tab>",     mode = { "n", "v" } },
              jump_prev_field_end = { "<S-Tab>",   mode = { "n", "v" } },
              jump_next_row       = { "<Enter>",   mode = { "n", "v" } },
              jump_prev_row       = { "<S-Enter>", mode = { "n", "v" } },
            },
          })
      end
    }
  },

}, {
  load = function(plug_data)
    vim.cmd.packadd(plug_data.spec.name)
    if plug_data.spec.data then
      if plug_data.spec.data.config then
        plug_data.spec.data.config(plug_data.spec)
      end
    end
  end,
})
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.data then
      if ev.data.spec.data.hook then
        ev.data.spec.data.hook(ev)
      end
    end
  end,
})

