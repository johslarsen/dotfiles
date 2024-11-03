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
  local pos = vim.fn.search('^\\s*class ', 'bcnw')
  if (pos == 0) then return "" end
  return string.gsub(vim.fn.getline(pos), ".*class *([^ ]+).*", "%1")
end

return M
