local function setup_lsp()
  require('mason').setup()
  local mason = require('mason')
  local mason_lspconfig = require('mason-lspconfig')
  local kagutsuchi_lsp = require('kagutsuchi.lsp')

  mason.setup()
  mason_lspconfig.setup()
  kagutsuchi_lsp.setup()
end

return {
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    config = setup_lsp,
  },

  {
    'mrcjkb/haskell-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    branch = '1.x.x',
  },

  {
    'simrat39/rust-tools.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',

      'mfussenegger/nvim-dap',
    },
    opts = require('kagutsuchi.lsp.rust-tools'),
  },
}
