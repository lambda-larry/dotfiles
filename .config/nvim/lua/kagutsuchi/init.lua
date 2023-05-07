local M = {}

local function supported_platform()
  return vim.fn.has('linux')
end

local function is_super_user()
  if vim.fn.has('linux') then
    return vim.loop.getuid() == 0
  end

  return false
end

function M.setup(opts)
  opts = opts or {}

  vim.g.mapleader = opts.leader or ' '
  vim.opt.guicursor = {
    -- Insert mode use beem cursor.
    'i-ci-ve:ver25',
    -- Normal mode use bar cursor.
    'n-v-c-sm:hor20',
    -- Replace mode use cursor.
    'r-cr-o:block',
    -- All modes blink the cursor.
    'a:blinkon250-blinkoff250',
  }

  if supported_platform() and not is_super_user() then
    require('kagutsuchi.bootstrap')
  end

end

return M
