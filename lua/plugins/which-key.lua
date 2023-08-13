-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 书签管理                                                                     │
-- │ docs: https://github.com/folke/which-key.nvim                                │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
require("which-key").setup({
  ignore_missing = false, -- 忽略没有wk.register 的快捷键映射
  show_help = true, -- 显示帮助信息
  triggers = "auto", -- 哪些按键可以触发 which-key 显示,如果手动设置可能导致一些功能失效
  plugins = {
    -- 禁止单词拼写插件
    spelling = {
      enabled = false,
    },
  },
  icons = {
    -- 图标
    breadcrumb = "↣",
    separator = "➤",
    group = "+",
  },
  window = {
    -- 窗口样式
    border = "single", -- none | single | double | shadow
    winblend = 0,
  },
  layout = {
    -- 布局
    spacing = 4,
    align = "center", -- left | center | right
  },
  disable = {
    -- 禁止菜单的 filetype 或 buftype
    buftypes = {},
    filetypes = { "TelescopePrompt", "NvimTree" },
  },
  triggers_blacklist = {
    i = { "j", "k" },
    v = { "j", "k" },
  },
})
