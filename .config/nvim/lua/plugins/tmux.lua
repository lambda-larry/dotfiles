return {
  {
    'alexghergh/nvim-tmux-navigation',
    opts = {
      keybindings = {
        left = "<C-h>",
        down = "<C-j>",
        up = "<C-k>",
        right = "<C-l>",
        last_active = "<C-\\>",
        next = "<C-Space>",
      },
    }
  },
  {
    'jpalardy/vim-slime',
    config = function()
      vim.g.slime_paste_file = vim.env.XDG_RUNTIME_DIR .. '/.slime_paste'

      vim.g.slime_target = 'neovim'

      if vim.env['TMUX'] then
        vim.g.slime_target = 'tmux'
        vim.g.slime_default_config = {
          socket_name = string.gsub(vim.env['TMUX'], ',.*', ''),
          target_pane = '{last}',
        }
      end
    end,
  },
}
