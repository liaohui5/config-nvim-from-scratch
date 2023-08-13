--  ╭──────────────────────────────────────────────────────────────────────────────╮
--  │ 输入行号时,预览对应的行,而不是直接跳过去                                     │
--  │ https://github.com/nacro90/numb.nvim                                         │
--  ╰──────────────────────────────────────────────────────────────────────────────╯
-- {
--   -- 跳转行号时预览对应的行
--   "nacro90/numb.nvim",
--   config = function()
--     require("plugins.numb")
--   end,
--   event = "VeryLazy",
-- },
require("numb").setup({
  show_numbers = true,
  show_cursorline = true,
  hide_relativenumbers = true,
  number_only = false,
  centered_peeking = true,
})
