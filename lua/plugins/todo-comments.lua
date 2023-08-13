-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │  高亮TODO注释                                                                │
-- │  docs: https://github.com/folke/todo-comments.nvim                           │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
-- stylua: ignore
require("todo-comments").setup({
  signs = true,      -- 在数字栏显示图片
  sign_priority = 8, -- 图标优先级
  keywords = {       -- 高亮关键字
    FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
    TODO = { icon = " ", color = "info" },
    HACK = { icon = " ", color = "warning" },
    WARN = { icon = " ", color = "warning", alt = { "WARNING", "WARN" } },
    PERF = { icon = " ", alt = { "PERFORMANCE", "OPTIMIZE" } },
    NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
    TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
  },
  gui_style = {
    fg = "NONE",
    bg = "NONE",
  },
  merge_keywords = true,
  highlight = {
    multiline = false,               -- 是否允许多行高亮显示
    multiline_pattern = "^.",        -- 多行匹配正则表达式
    multiline_context = 10,          -- 如果开启多行(最多多少行)
    before = "",                     -- "fg" or "bg" or empty
    keyword = "bg",                  -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty
    after = "",                      -- "fg" or "bg" or empty
    pattern = [[.*<(KEYWORDS)\s*:]], -- 高亮匹配正则表达式
    comments_only = true,            -- 只在注释中生效
    max_line_len = 150,              -- 忽略太长的行
    exclude = {},                    -- 忽略指定文件的注释高亮
  },

  colors = {
    -- 高亮背景颜色
    error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
    warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
    info = { "DiagnosticInfo", "#2563EB" },
    hint = { "DiagnosticHint", "#10B981" },
    default = { "Identifier", "#7C3AED" },
    test = { "Identifier", "#FF00FF" },
  },
  search = {
    -- 搜索命令和参数
    command = "rg",
    args = {
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
    },
    -- 匹配关键字正则表达式
    pattern = [[\b(KEYWORDS):]],
  },
})
