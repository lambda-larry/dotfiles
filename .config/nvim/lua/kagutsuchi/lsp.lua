local M = {}


function M.setup()
  local mason_lspconfig = require('mason-lspconfig')
  local kagutsuchi_lsp = require('kagutsuchi.lsp.config')
  local lsp_default_config = kagutsuchi_lsp.default
  require('lspconfig.ui.windows').default_options = {
    border = 'single',
  }

  for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
    local lsp_config = kagutsuchi_lsp.config(server)
    if lsp_config then
      lsp_config = vim.tbl_extend('force', lsp_default_config, lsp_config)
      require('lspconfig')[server].setup(lsp_config)
    end
  end
end


return M
