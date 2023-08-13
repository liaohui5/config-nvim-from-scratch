-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │  LSP UI 美化                                                                 │
-- │  docs: https://github.com/glepnir/lspsaga.nvim                               │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
local keys = require("keybindings").lspsagaKeys()
require("lspsaga").setup({
  request_timeout = 1000,
  scroll_preview = keys.scroll_preview,
  finder = keys.finder,
  definition = keys.definition,
  preview = {
    -- 预览窗口
    lines_above = 0,
    lines_below = 10,
  },
  code_action = {
    -- 代码建议
    num_shortcut = true,
    keys = keys.code_action,
  },
  diagnostic = {
    -- 代码诊断
    on_insert = true,
    show_virt_line = true,
    show_code_action = true,
    show_source = true,
    jump_num_shortcut = true,
    max_width = 0.6, -- 0.1 ~ 1
    border_follow = true,
    keys = keys.diagnostic,
  },
  lightbulb = {
    -- 代码建议(小灯泡)
    enable = true,
    enable_in_insert = true,
    sign = false,
    sign_priority = 40,
    virtual_text = true,
  },
  rename = {
    -- 重命名变量(包括引用)
    in_select = true,
    confirm = keys.rename.confirm,
    quit = keys.rename.quit,
    exec = keys.rename.exec,
    mark = keys.rename.mark,
  },
  outline = {
    -- 变量/函数/类列表
    -- 类似: https://github.com/simrat39/symbols-outline.nvim
    win_position = "right",
    win_with = "",
    win_width = 35,
    show_detail = false,
    auto_preview = false,
    auto_refresh = true,
    auto_close = true,
    custom_sort = nil,
    keys = keys.outline,
  },
  symbol_in_winbar = {
    -- 顶部栏路径显示
    -- 类似: https://github.com/SmiteshP/nvim-navic
    enable = true,
    separator = "  ",
    hide_keyword = true,
  },
  ui = {
    theme = "round", -- 目前只支持这一个主题
    border = "single", -- 可选值: single,double,rounded,solid,shadow.
    title = true,
    winblend = 0,
    expand = "",
    collapse = "",
    preview = " ",
    code_action = "󰌵",
    diagnostic = "",
    incoming = "󰏷 ",
    outgoing = "󰏻 ",
    hover = " ",
    -- 自定义图标
    -- https://github.com/glepnir/lspsaga.nvim#custom-kind
    -- kind = {},
  },
})
