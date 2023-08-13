----------------------------------------------------
-- 注释插件
-- docs: https://github.com/numToStr/Comment.nvim
-- others: https://github.com/JoosepAlviste/nvim-ts-context-commentstring
----------------------------------------------------
local api = require("Comment.api")
local ok, tscc = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
local pre_hook = nil
if ok then
  pre_hook = tscc.create_pre_hook()
end
require("keybindings").commentKeys(api)
require("Comment").setup({
  padding = true,
  sticky = true,
  ignore = nil,
  mappings = {
    -- 禁止默认的快捷键
    --- Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
    --- Extra mapping; `gco`, `gcO`, `gcA`
    basic = false,
    extra = false,
  },
  pre_hook = pre_hook,
  post_hook = nil,
})
