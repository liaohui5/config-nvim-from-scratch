----------------------------------------------------
-- 快速移动光标位置, 类似 easymontion
-- docs: https://github.com/phaazon/hop.nvim
-- 替代插件: https://github.com/ggandor/leap.nvim
----------------------------------------------------
local hop = require("hop")

hop.setup({ keys = "etovxqpdygfblzhckisuran12345" })
require("keybindings").hopKeys()
