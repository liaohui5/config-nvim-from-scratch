-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ LSP 代码检测插件                                                             │
-- │ docs:                                                                        │
-- │ https://github.com/jose-elias-alvarez/null-ls.nvim                           │
-- │ https://github.com/jay-babu/mason-null-ls.nvim                               │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
-- local installer = require("mason-tool-installer")
local mason_null_ls = require("mason-null-ls")
local null_ls = require("null-ls")

-- 先自动安装需要的包
mason_null_ls.setup({
  automatic_installation = true,
  ensure_installed = {
    "stylua",
    "eslint_d",
    "dprint",
    "shellcheck",
    "shfmt",
    -- "prettier",
    -- "prettierd",
  },
})

null_ls.setup({
  debug = false,
  sources = {
    -- 打开 debug 模式可以查看命令的运行日志
    -- sources 支持的包列表: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
    -- null_ls.builtins.diagnostics.eslint_d,
    -- null_ls.builtins.code_actions.eslint_d,
    -- null_ls.builtins.formatting.prettier,
    -- null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.dprint,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.formatting.shfmt,
  },
})
