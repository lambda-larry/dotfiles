vim.cmd('compiler gcc')

vim.opt.cinoptions = ''
vim.opt.cinoptions:append 't0'   -- indentation of return type
vim.opt.cinoptions:append ':0'   -- indentation of case   label
vim.opt.cinoptions:append 'l1'
vim.opt.cinoptions:append '=-1s'
