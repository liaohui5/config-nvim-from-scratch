--  ╭──────────────────────────────────────────────────────────────────────────────╮
--  │ 更具代码自动生成对应的注释                                                   │
--  │ https://github.com/danymat/neogen                                            │
--  ╰──────────────────────────────────────────────────────────────────────────────╯
local neogen = require("neogen")

-- 显示选择菜单: 用于选择生成注释的类型
local function showNeogenActionMenus()
  local types = {
    "type",
    "func",
    "file",
    "class",
  }
  local options = {
    prompt = "Please select generate comment type:",
  }
  vim.ui.select(types, options, function(selected)
    neogen.generate({ type = selected })
  end)
end

neogen.setup({
  enable = true,
  snippet_engine = "luasnip",
  input_after_comment = true,
})
require("keybindings").neogenKeys(showNeogenActionMenus)
