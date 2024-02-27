local function endswith(str, suffix)
  return str:sub(- #suffix) == suffix
end

local function relpath(path)
  return vim.fn.fnamemodify(path, ':p:~:.')
end

local function src_or_test_filename()
  local org = relpath(vim.api.nvim_buf_get_name(0))
  local src = org:gsub("_?[Tt]est/?", "")
  if (org ~= src) then
    if vim.fn.filereadable(src) == 1 then return src end
    for _, candidate in pairs(vim.fn.glob(src:gsub("[.][^.]*$", ".*"), false, true)) do
      return candidate
    end
    for _, candidate in pairs(vim.fn.glob("*/" .. src:gsub("[.][^.]*$", ".*"), false, true)) do
      return candidate
    end
  else
    for _, pattern in pairs({ "_test%0", "Test%0", "_test*", "Test*" }) do
      for _, candidate in pairs(vim.fn.glob(org:gsub("[.][^.]*$", pattern), false, true)) do
        return candidate
      end
      for _, candidate in pairs(vim.fn.glob("test/" .. org:gsub("[.][^.]*$", pattern), false, true)) do
        return candidate
      end
      for _, candidate in pairs(vim.fn.glob("test/" .. org:gsub("^[^/]*/", ""):gsub("[.][^.]*$", pattern), false, true)) do
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


local function run_in_testbuf(fun)
  if vim.api.nvim_buf_get_name(0):match("[Tt]est") == nil then
    local test = src_or_test_filename()
    if test ~= nil then
      for _, bufid in ipairs(vim.api.nvim_list_bufs()) do
        if endswith(vim.api.nvim_buf_get_name(bufid), test) then
          return vim.api.nvim_buf_call(bufid, fun)
        end
      end
    end
  end
  return fun()
end

local function doctest_suite()
  local pattern = 'TEST_SUITE[^(]*("\\([^"]*\\)"'
  local pos = vim.fn.search(pattern, 'bcnw')
  if (pos == 0) then return '*' end -- TODO: guess filename
  return vim.fn.trim(vim.fn.matchlist(vim.fn.join(vim.fn.getline(pos, pos + 2)), pattern)[2])
end
local function doctest_case()
  local pattern = 'TEST_CASE[^(]*("\\([^"]*\\)"'
  local pos = vim.fn.search(pattern, 'bcnw')
  if (pos == 0) then return '*' end
  return vim.fn.trim(vim.fn.matchlist(vim.fn.join(vim.fn.getline(pos, pos + 2)), pattern)[2])
end
local function doctest_context()
  return doctest_suite(), doctest_case()
end

local function gtest_context()
  local id = '[[:alnum:]_[:space:]\n]'
  local pattern = 'TEST' .. id .. '*(\\(' .. id .. '\\+\\),\\(' .. id .. '\\+\\))'

  return run_in_testbuf(function()
    local pos = vim.fn.search(pattern, 'bcnw')
    if pos == 0 then return doctest_context() end

    local match = vim.fn.matchlist(vim.fn.join(vim.fn.getline(pos, pos + 2)), pattern)
    return vim.fn.trim(match[2]), vim.fn.trim(match[3])
  end)
end

local function make_with(makeprg, errorformat)
  local old_errorformat = vim.bo.errorformat
  vim.bo.errorformat = errorformat
  local old_makeprg = vim.bo.makeprg
  vim.bo.makeprg = makeprg
  vim.cmd.Make()
  vim.bo.makeprg = old_makeprg
  vim.bo.errorformat = old_errorformat
end
local function ctest(errorformat)
  local makeprg = vim.env.BUILD_IMAGE ~= nil and 'dtest ' .. vim.env.BUILD_IMAGE or 'ctest --test-dir build'
  if (vim.env.CTEST_FILTER ~= nil) then
    local suite = vim.env.TEST_SUITE:gsub('[*]', '.*')
    local case = vim.env.TEST_CASE:gsub('[*]', '.*')
    local filter = vim.env.CTEST_FILTER:gsub('#s', suite):gsub('#c', case)
    makeprg = makeprg .. ' -R ' .. vim.fn.shellescape(filter)
  end
  make_with(makeprg, errorformat)
end

local original_test_suite = vim.env.TEST_SUITE
local function ctest_gtest(suite, case)
  vim.env.TEST_SUITE = suite or original_test_suite or '*' -- doctest
  vim.env.TEST_CASE = case or '*'                         -- doctest

  -- '*' in the middle to support '/<N>' part of TYPED_TESTs names
  vim.env.GTEST_FILTER = vim.env.TEST_SUITE .. '*.' .. vim.env.TEST_CASE

  vim.env.GTEST_COLOR = '0' -- causes problems in output
  vim.env.ASAN_OPTIONS = 'coverage=1'
  vim.env.CTEST_OUTPUT_ON_FAILURE = '1'

  local errorformat = ''
      .. '%.%#: %f:%l: %m' -- C/C++ assertions
      .. ',%Z[%.%#] %m'
      .. ',%C%m'
      .. ',%.%#Subprocess %m'       -- ctest: hacky way to catch gtest segfault errors++
      .. ',%A%f:%l: %t%*[^:]:\\ %m' -- doctest: assertions, ...
      .. ',%A%f:%l: %t%.%#'         -- gtest: assertions, ...
      .. ',%EFAIL: %f'              -- gtest segault, exceptions, ...
  ctest(errorformat)
end
vim.keymap.set('n', '<Leader>yy', ctest_gtest)
vim.keymap.set('n', '<Leader>yf', function() ctest_gtest(select(1, gtest_context()), '*') end)
vim.keymap.set('n', '<Leader>yt', function() ctest_gtest(gtest_context()) end)

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "ruby" },
  callback = function()
    local function minitest()
      run_in_testbuf(function()
        local errorformat = ''
          ..  '%.%#: %f:%l: %tarning %m'
          .. ',%[%^/]%#%f:%l: %tarning: %m'
          .. ',%.%#: %f:%l: %m%trror)'
          .. ',%[%^/]%#%f:%l: %m%trror)'
          .. ',%A%[ ]%#%n) %tailure:'
          .. ',%C%.%##%m [%f:%l]:'
          .. ',%C%m but nothing was raised.'
          .. ',%CExpected %m'
          .. ',%C[%m'
          .. ',%CClass: <%m>'
          .. ',%CMessage: %m'
          .. ',%A%[ ]%#%l) %trror:'
          .. ',%C%f#%m:'
          .. ''
          .. ',%-Z---Backtrace---' --backtrace lines as new general info
          .. ',%-G------%.%#'
          .. ',%[[:space:]]%#from %f:%l:%m'
          .. ',%[[:space:]]%#%f:%l:%m'
          .. ',%Z'
          .. ''
          .. ',%-G'
          .. ',%-G# Running:'
          .. ',%-Grake aborted!'
          .. ',%-GCommand failed with status (%.%#'
          .. ',%-G/usr%.%#lib:test" -I%.%#'
          .. ',%-GTasks: %.%#'
          .. ',%-G(See full trace by running task with --trace)'
          .. ''
          .. ',%C%m'
          .. ',%C%p'
        make_with('ruby ' .. vim.api.nvim_buf_get_name(0) .. ' -v', errorformat)
      end)
    end
    vim.keymap.set('n', '<Leader>yf', minitest)
    vim.keymap.set('n', '<Leader>yt', minitest)
  end
})
