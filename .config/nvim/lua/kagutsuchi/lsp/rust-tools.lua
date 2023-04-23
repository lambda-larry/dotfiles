return {
  server = {
    on_attach = require('kagutsuchi.lsp.config').default.on_attach,
    settings = {
      ['rust-analyzer'] = {
        cargo = {
          buildScripts = {
            enable = true,
          },
        },
        procMacro = {
          enable = true,
        },
      },
    },
  },
}
