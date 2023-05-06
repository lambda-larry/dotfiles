local ht = require('haskell-tools')

ht.start_or_attach {
  hls = vim.tbl_extend('force', require('kagutsuchi.lsp.config').default, {
  }),
}
