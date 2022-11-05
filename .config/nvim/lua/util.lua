local M = { vim = {} }

function M.vim.opt(options)
  for key, value in pairs(options) do
    vim.opt[key] = value
  end
end

function M.merge(table, update)
  result = {}

  for key, value in pairs(table) do
    result[key] = value
  end

  for key, value in pairs(update) do
    result[key] = value
  end

  return result
end

return M
