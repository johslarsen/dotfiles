local M = {}

local function decorator_from_path(path)
  return string.gsub(vim.fn.substitute(path, "^\\(include\\|lib\\|src\\)/", "", ""), "/", "::")
end

M.namespace_from_file = function()
  return decorator_from_path(vim.fn.expand("%:h"))
end
M.class_from_file = function()
  return decorator_from_path(vim.fn.expand("%:t:r"))
end
M.qualified_class_from_file = function()
  return decorator_from_path(vim.fn.expand("%:r"))
end
M.class_from_line = function()
  local pattern = '^\\s*\\(class\\|struct\\)\\(.*::\\)\\? *\\([^ ]\\+\\).*'
  local pos = vim.fn.search(pattern, 'bcnW')
  if (pos == 0) then return "" end
  return vim.fn.substitute(vim.fn.getline(pos), pattern, "\\3", "")
end

return M
