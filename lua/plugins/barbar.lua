-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 顶部标签页                                                                   │
-- │ docs: https://github.com/romgrk/barbar.nvim                                  │
-- │ https://github.com/akinsho/bufferline.nvim                                   │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
local barbar = require("barbar")
require("keybindings").barbarKeys()

barbar.setup({
  exclude_ft = {},
  exclude_name = {},
  animation = false,
  auto_hide = false,
  tabpages = false,
  closable = true,
  clickable = false,
  insert_at_end = true,
  insert_at_start = false,
  maximum_padding = 2,
  maximum_length = 30,
  semantic_letters = true,
  no_name_title = nil,
  letters = "asdfjklghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP12345",
  icons = {
    button = ""
  }
})
