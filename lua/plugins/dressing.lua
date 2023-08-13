-------------------------------------------------------------------------------
-- 改进默认的UI样式
-- https://github.com/stevearc/dressing.nvim
-------------------------------------------------------------------------------
local mappings = require("keybindings").dressingKeys()
require("dressing").setup({
  select = {
    enabled = true,
    trim_prompt = true,
  },
  input = {
    enabled = true,
    default_prompt = "Input:",
    title_pos = "left",
    start_in_insert = true,
    insert_only = false, -- only support insert mode in input
    border = "single",   -- single | rounded | double
    relative = "cursor",
    mappings = mappings,
  },
})
