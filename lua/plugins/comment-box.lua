-- ╭──────────────────────────────────────────────────────────────────────────────╮ --
-- │                                                                              │ --
-- │                               块注释插件                                     │ --
-- │            docs: https://github.com/LudoPinelli/comment-box.nvim             │ --
-- │                                                                              │ --
-- ╰──────────────────────────────────────────────────────────────────────────────╯ --
require("comment-box").setup({
  line_width = 80,
  doc_width = 80,
  box_width = 80,
  borders = {
    top = "─",
    bottom = "─",
    left = "│",
    right = "│",
    top_left = "╭",
    top_right = "╮",
    bottom_left = "╰",
    bottom_right = "╯",
  },
  line = {
    line = "─",
    line_start = "─",
    line_end = "─",
  },
  outer_blank_lines = false,
  inner_blank_lines = false,
  line_blank_line_above = false,
  line_blank_line_below = false,
})

require("keybindings").commentBoxKeys()
