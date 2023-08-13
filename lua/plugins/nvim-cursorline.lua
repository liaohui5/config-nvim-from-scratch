--  ╭──────────────────────────────────────────────────────────────────────────────╮
--  │ 自动匹配当前光标下的单词高亮                                                 │
--  │ docs: https://github.com/yamatsum/nvim-cursorline                            │
--  │ 类似插件: https://github.com/RRethy/vim-illuminate                           │
--  ╰──────────────────────────────────────────────────────────────────────────────╯
require("nvim-cursorline").setup({
  cursorline = {
    enable = false,
    timeout = 1000,
    number = false,
  },
  cursorword = {
    enable = true,
    min_length = 2, -- 单词最小字母数
    hl = {
      underline = true, -- 高亮样式
    },
  },
})
