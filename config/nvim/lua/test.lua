local function src_or_test_filename()
  local org = vim.api.nvim_buf_get_name(0)
  local src = org:gsub("_?[Tt]est", "")
  if (org ~= src) then
    if vim.fn.filereadable(src) == 1 then return src end
    for _, candidate in pairs(vim.fn.glob(src:gsub("[.][^.]*$", ".*"), false, true)) do
      return candidate
    end
    return vim.fn.filereadable(src) == 1 and src or nil
  else
    for _, pattern in pairs({ "_test%0", "Test%0", "_test*", "Test*" }) do
      for _, candidate in pairs(vim.fn.glob(org:gsub("[.][^.]*$", pattern), false, true)) do
        return candidate
      end
    end
  end
end
local function edit_non_nil(path, before)
  if (path == nil) then return end
  if (before ~= nil) then before() end
  vim.cmd.edit(path)
end
vim.keymap.set('n', '<Leader>t', function() edit_non_nil(src_or_test_filename()) end)
vim.keymap.set('n', '<Leader>T', function() edit_non_nil(src_or_test_filename(), vim.cmd.vsplit) end)
vim.keymap.set('n', '<Leader><C-t>', function() edit_non_nil(src_or_test_filename(), vim.cmd.split) end)


local function gtest_context()
  local id = '[[:alnum:]_[:space:]\n]'
  local pattern = 'TEST' .. id .. '*(\\(' .. id .. '\\+\\),\\(' .. id .. '\\+\\))'

  local pos = vim.fn.search(pattern, 'bcnw')
  if pos == 0 then return {'*', '*'} end

  local match = vim.fn.matchlist(vim.fn.join(vim.fn.getline(pos, pos + 2)), pattern)
  return { vim.fn.trim(match[2]), vim.fn.trim(match[3]) }
end

local function ctest()
  local makeprg = vim.o.makeprg
  if (vim.env.BUILD_IMAGE ~= nil) then
    vim.o.makeprg = 'dtest ' .. vim.env.BUILD_IMAGE
  else
    vim.o.makeprg = 'ctest --test-dir build'
  end

  if (vim.env.CTEST_FILTER ~= nil) then
    vim.o.makeprg = vim.o.makeprg .. ' -R ' .. vim.fn.shellescape(vim.env.CTEST_FILTER)
  elseif (vim.env.GTEST_FILTER ~= nil) then
    vim.o.makeprg = vim.o.makeprg .. ' -R ' .. vim.fn.shellescape(vim.env.GTEST_FILTER:gsub("[*]", ".*"))
  end
  vim.cmd.Make()
  vim.o.makeprg = makeprg
end

local function ctest_gtest(filter)
  local old_errorformat = vim.o.errorformat

  vim.o.errorformat = ''
      .. '%.%#: %f:%l: %m' -- C/C++ assertions
      .. ',%Z[%.%#] %m'
      .. ',%C%m'
      .. ',%.%#Subprocess %m'       -- ctest: hacky way to catch gtest segfault errors++
      .. ',%A%f:%l: %t%*[^:]:\\ %m' -- doctest: assertions, ...
      .. ',%A%f:%l: %t%.%#'         -- gtest: assertions, ...
      .. ',%EFAIL: %f'              -- gtest segault, exceptions, ...

  vim.env.GTEST_COLOR = '0'         -- causes problems in output
  vim.env.GTEST_FILTER = filter or '*'
  vim.env.ASAN_OPTIONS = 'coverage=1'
  vim.env.CTEST_OUTPUT_ON_FAILURE = '1'

  ctest()
  vim.o.errorformat = old_errorformat
end
vim.keymap.set('n', '<Leader>yy', ctest_gtest)
vim.keymap.set('n', '<Leader>yf', function() ctest_gtest(gtest_context()[1]..".*") end)
vim.keymap.set('n', '<Leader>yt', function() ctest_gtest(vim.fn.join(gtest_context(), ".")) end)
