-----------------------------------------------------
-- 快速移动光标位置插件 leap.nvim 的 f/t 增强插件
-- 必须依赖 leap.nvim 才能使用
-- docs: https://github.com/ggandor/flit.nvim
-----------------------------------------------------
local flit = require("flit")

-- leap 增强插件: f/t
flit.setup({
  keys = { f = "f", F = "F", t = "t", T = "T" },
  labeled_modes = "v",
  multiline = true, -- 是否多行匹配
  opts = {},
})
