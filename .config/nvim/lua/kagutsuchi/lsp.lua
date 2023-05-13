local lspconfig = require('lspconfig')
local M = {}


local function setup_hook(config)

  -- Ignore LSP on project root that contains lspignore.kagutsuchi
  local old_root_dir = config.root_dir -- Avoid infinite recursion
  config.root_dir = function(...)
    local path = lspconfig.util.path
    local root_dir = old_root_dir(...)

    if root_dir ~= nil and path.is_file(path.join(root_dir .. '/lspignore.kagutsuchi')) then
      config.single_file_support = false
      return nil
    end

    return root_dir
  end

end

function M.setup()
  local mason_lspconfig = require('mason-lspconfig')
  local kagutsuchi_lsp = require('kagutsuchi.lsp.config')
  local lsp_default_config = kagutsuchi_lsp.default
  require('lspconfig.ui.windows').default_options = {
    border = 'single',
  }

  lspconfig.util.on_setup = lspconfig.util.add_hook_before(
    lspconfig.util.on_setup,
    setup_hook
  )

  for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
    local lsp_config = kagutsuchi_lsp.config(server)
    if lsp_config then
      lsp_config = vim.tbl_extend('force', lsp_default_config, lsp_config)
      lspconfig[server].setup(lsp_config)
    end
  end
end


return M
