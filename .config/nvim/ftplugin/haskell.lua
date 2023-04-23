local ht = require('haskell-tools')
local on_attach = require('kagutsuchi.lsp.config').default.on_attach

ht.start_or_attach {
  hls = {
    on_attach = on_attach,
  }
}
