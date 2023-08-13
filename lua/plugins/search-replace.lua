--  ╭──────────────────────────────────────────────────────────────────────────────╮
--  │ 快速搜索替换                                                                 │
--  │ docs: https://github.com/roobert/search-replace.nvim                         │
--  ╰──────────────────────────────────────────────────────────────────────────────╯
-- commands: https://github.com/roobert/search-replace.nvim#microscope-available-commands
-- 推荐阅读: https://harttle.land/2016/08/08/vim-search-in-file.html#header-7
-- 1. vim 搜索替换标志符:
--   i: ignore 忽略大小写
--   I: ignore 严格检查大小写
--   c: confirm 每次需要确认替换
--   g: global 全局替换
-- 2. 确认菜单(加上c标识符)才会出现的: replace with xxx (y/n/a/q/l/^E/^Y)?
--   y: yes  确定替换
--   n: no   不要替换
--   a: all  替换所有
--   q: quit 退出查找替换模式
--   l: last 最后一次替换(本次执行完后,退出查找替换模式)
--  ^E: 向上移动光标
--  ^Y: 向下移动光标
require("search-replace").setup({
  default_replace_single_buffer_options = "gcI",
  default_replace_multi_buffer_options = "egcI",
})

require("keybindings").searchReplaceKeys()
