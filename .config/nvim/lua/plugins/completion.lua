return {
  {
    'hrsh7th/cmp-nvim-lua',
    dependencies = {
      'hrsh7th/nvim-cmp',
    },
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
    },
    config = function()
      -- Set up nvim-cmp.
      local cmp = require('cmp')

      cmp.setup({
        snippet = {
          expand = function(_)
          end,
        },
        view = {
          entries = 'native',
        },
        window = {
          completion = cmp.config.window.bordered({
            border = 'single',
          }),
          documentation = cmp.config.window.bordered({
            border = 'single',
          }),
        },
        mapping = cmp.mapping.preset.insert(),
        sources = cmp.config.sources(
          {
            { name = 'nvim_lua' },
            { name = 'nvim_lsp' },
            { name = 'nvim_lsp_signature_help' },
          }
        )
      })
    end,
  },
}
