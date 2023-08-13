-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 代码格式刷配置                                                               │
-- │ docs: https://github.com/mhartington/formatter.nvim                          │
-- │ prettier:  https://prettier.io/docs/en/index.html                            │
-- │ 同类插件: https://github.com/sbdchd/neoformat                                │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
local formatter = require("formatter")

-- prettier 支持的语言
local prettierSupported = {
  javascript = true,
  javascriptreact = true,
  typescript = true,
  typescriptreact = true,
  css = true,
  scss = true,
  less = true,
  vue = true,
  html = true,
  yaml = true,
  json = true,
  markdown = true,
  graphql = true,
}

-- 使用 prettier 格式化
local function prettierFormatter()
  return {
    exe = "prettier",
    stdin = true,
    args = {
      "--stdin-filepath",
      vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
    },
  }
end

local filetype = {}
for key in pairs(prettierSupported) do
  filetype[key] = {
    prettierFormatter,
  }
end

-- prettier 支持的文件就用 prettier 格式化, 否则用 lsp 来格式化
local documentFormat = function()
  local scope = ""
  if prettierSupported[vim.bo.filetype] then
    scope = "[formatter]"
    vim.cmd("FormatWrite")
  else
    scope = "[lsp]"
    local buf = vim.lsp.buf
    local format = buf.formatting_seq_sync or buf.format
    if type(format) == "function" then
      format()
    else
      print("[format]: cannot format document")
      return
    end
  end
  print(scope .. "Document formated at " .. vim.fn.strftime("%T"))
end

formatter.setup({ filetype = filetype })

require("keybindings").formatterKeys(documentFormat)
