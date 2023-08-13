--  ╭──────────────────────────────────────────────────────────────────────────────╮
--  │ 自动切换输入法                                                               │
--  │ docs: https://github.com/keaising/im-select.nvim                             │
--  ╰──────────────────────────────────────────────────────────────────────────────╯
local im_select = require("im_select")

im_select.setup({
  default_im_select = "com.apple.keylayout.ABC", -- MacOS 默认的英文输入法
  set_previous_events = {},                      -- 进入插入模式时, 是否自动恢复上一次输入法状态 0:恢复 1:禁用
})
