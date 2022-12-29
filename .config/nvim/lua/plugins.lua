local util = require('util')


return require('packer').startup(function(use)

  local extension = {}
  function extension.template(plugin)
    -- TODO check parameter type
    return function(config)

      local dependencies = { { plugin } }
      dependencies = util.merge(dependencies, config.requires or {})


      local packer_config = {
        requires = dependencies
      }
      use(util.merge(packer_config, config))
    end
  end

  extension.treesitter = extension.template('nvim-treesitter/nvim-treesitter')
  extension.telescope  = extension.template('nvim-telescope/telescope.nvim')

  local if_tmux = function()
      return vim.env['TMUX'] ~= nil
  end


  use { 'wbthomason/packer.nvim', config = require('plugins.packer') }

  use 'dracula/vim'
  use 'editorconfig/editorconfig-vim'

  use { 'alexghergh/nvim-tmux-navigation',
    config = require('plugins.tmux'),
    cond = if_tmux,
  }

  use { 'jpalardy/vim-slime',
    config = require('plugins.slime'),
    cond = if_tmux,
  }

  use { 'mhinz/vim-startify', config = require('plugins.startify'), }

  use { 'nvim-treesitter/nvim-treesitter', config = require('plugins.treesitter'),
    requires = { {'dracula/vim'} }
  }

  extension.treesitter { 'p00f/nvim-ts-rainbow', }
  extension.treesitter { 'nvim-treesitter/nvim-treesitter-textobjects', }

  use 'nvim-tree/nvim-web-devicons'

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function() require('lualine').setup({}) end,
  }

  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function()
      require('telescope').setup {

        defaults = {
          theme = "dropdown",
          mappings = {
            i = {
              ["<C-u>"] = false,
            },
          },
        },

        extensions = {
          heading = {
            treesitter = true,
          },
        },
      }

    end
  }

  extension.telescope {
    'nvim-telescope/telescope-project.nvim',
    config = function()
      require('telescope').load_extension('project')
    end
  }

  extension.telescope {
    'crispgm/telescope-heading.nvim',
    config = function()
      local keymap = function()
        vim.keymap.set('n', 'gO', function()
          vim.cmd.Telescope("heading")
        end, {
          buffer = true,
          noremap = false,
        })
      end
      require('telescope').load_extension('heading')
      vim.api.nvim_create_autocmd("FileType", {
        pattern  = "markdown,help,latex,asciidoc",
        callback = keymap,
      })

    end
  }

  use 'tpope/vim-repeat'

  use 'mxw/vim-prolog'

  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }

  use 'lambda-larry/vim-vinegar.nvim'

  use 'souffle-lang/souffle.vim'
end)
