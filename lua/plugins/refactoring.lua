--  ╭──────────────────────────────────────────────────────────────────────────────╮
--  │ 快速重构代码辅助插件                                                         │
--  │ https://github.com/ThePrimeagen/refactoring.nvim                             │
--  ╰──────────────────────────────────────────────────────────────────────────────╯
-- 生成一个重构选择菜单
local refactoring = require("refactoring")
refactoring.setup({
  -- stylua: ignore
  prompt_func_return_type = {
    go   = true,
    java = true,
    cpp  = true,
    c    = true,
    h    = true,
    hpp  = true,
    cxx  = true,
    js   = true,
    ts   = true,
  },
  -- stylua: ignore
  prompt_func_param_type = {
    go   = true,
    java = true,
    cpp  = true,
    c    = true,
    h    = true,
    hpp  = true,
    cxx  = true,
    js   = true,
    ts   = true,
  },
  printf_statements = {},
  print_var_statements = {},
})
require("keybindings").refactoringKeys(refactoring)
