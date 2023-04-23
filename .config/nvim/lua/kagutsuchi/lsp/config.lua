local M = {}

local border = 'single'

M.default = {
  on_attach = function(client, bufnr)
    local function map(mode, key, func, desc, cond)
      if not cond then
        return
      end

      local bufopts = {
        noremap = true,
        silent = true,
        buffer = bufnr,
        desc = desc
      }
      vim.keymap.set(mode, key, func, bufopts)
    end

    local capabilities = client.server_capabilities

    map('n', 'K',           vim.lsp.buf.hover,           'Hover',                capabilities.hoverProvider)
    map('n', '<leader>lh',  vim.lsp.buf.hover,           'Hover',                capabilities.hoverProvider)
    map('n', '<leader>lr',  vim.lsp.buf.rename,          'Rename',               capabilities.renameProvider)
    map('n', 'gi',          vim.lsp.buf.implementation,  'Goto implementation',  capabilities.implementationProvider)
    map('n', '<leader>lgi', vim.lsp.buf.implementation,  'Goto implementation',  capabilities.implementationProvider)
    map('n', 'gd',          vim.lsp.buf.definition,      'Goto definition',      capabilities.definitionProvider)
    map('n', '<leader>lgd', vim.lsp.buf.definition,      'Goto definition',      capabilities.definitionProvider)
    map('n', 'gD',          vim.lsp.buf.declaration,     'Goto declaration',     capabilities.declarationProvider)
    map('n', '<leader>lgD', vim.lsp.buf.declaration,     'Goto declaration',     capabilities.declarationProvider)
    map('n', 'gr',          vim.lsp.buf.references,      'Goto reference',       capabilities.referencesProvider)
    map('n', '<leader>lgr', vim.lsp.buf.references,      'Goto reference',       capabilities.referencesProvider)
    map('n', '<leader>lgt', vim.lsp.buf.type_definition, 'Goto type definition', capabilities.typeDefinitionProvider)
    map('n', '<leader>lc',  vim.lsp.buf.code_action,     'Code action',          capabilities.codeActionProvider)

    client.server_capabilities.semanticTokensProvider = nil
    require('completion').on_attach(client, bufnr)
  end,
  handlers = {
    ['textDocument/hover']         = vim.lsp.with(vim.lsp.handlers.hover,          { border = border }),
    ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
  },
  flags = {
    debounce_text_changes = 300,
  },
}

function M.config(server)
  local exists, lsp_config = pcall(require, 'kagutsuchi.lsp.config.' .. server)

  if exists == false then
    lsp_config = {}
  end

  return lsp_config
end

return M
