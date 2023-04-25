return {
  server = vim.tbl_extend('force', require('kagutsuchi.lsp.config').default, {
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
  }),
}
