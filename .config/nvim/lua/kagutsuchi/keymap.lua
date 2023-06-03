-- Only create keymap if Makefile exists
vim.api.nvim_create_autocmd('BufEnter', {
  desc = 'Create make keymap if makefile exists.',
  callback = function(opts)

    local makefile_names = {
      'Makefile',
      'makefile',
      'GNUmakefile',
    }
    local makefile_exists = 0

    for _, makefile in ipairs(makefile_names) do
        makefile_exists = makefile_exists + vim.fn.filereadable(makefile)
    end

    if makefile_exists == 0 then
      return
    end

    local bufnr = opts.buf or 0
    local bufopts = {
        noremap = true,
        silent = true,
        buffer = bufnr,
    }

    local which_key = require('which-key')
    which_key.register({
        m = '+make',
      }, {
        prefix = '<leader>',
        buffer = bufnr,
    })


    vim.keymap.set('n', '<leader><leader>m', '<cmd>make<cr>', bufopts)
    vim.keymap.set('n', '<leader>m<space>',  '<cmd>make<cr>', bufopts)
    vim.keymap.set('n', '<leader>mm',        '<cmd>make<cr>', bufopts)
    vim.keymap.set('n', '<leader>mc',  '<cmd>make clean<cr>', bufopts)
  end,
})
