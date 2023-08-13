-- ╭────────────────────────────────────────────────────────────────────────────────────────────╮
-- │  字符串两边的包裹字符操作                                                                  │
-- │  docs: https://github.com/kylechui/nvim-surround                                           │
-- ╰────────────────────────────────────────────────────────────────────────────────────────────╯
-- options: https://github.com/kylechui/nvim-surround/blob/main/lua/nvim-surround/config.lua
local keymaps = require("keybindings").nvimSurroundKeys()

require("nvim-surround").setup({
  keymaps = keymaps,
})
