return function()
  quotes = {
    {"Do not feel envious of the happiness of those who live in a fool’s paradise, for only a fool will think that it is happiness.", "", "- Bertrand Russell"},
  }
  vim.g.startify_lists = {
    { ['type'] = 'bookmarks', headers = '   Bookmarks' },
    { ['type'] = 'commands',  headers = '   Commands'  },
  }

  vim.g.startify_bookmarks = {
    { n = '~/.config/nvim/' },
  }

  vim.g.startify_commands = {
    { u = 'PackerSync' },
    { p = 'Telescope project' },
  }

  vim.g.startify_fortune_use_unicode = 1
  vim.g.startify_change_to_vcs_root  = 1

  vim.g.startify_custom_header_quotes = vim.fn["startify#fortune#predefined_quotes"]()

end
