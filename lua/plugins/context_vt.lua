--  ╭──────────────────────────────────────────────────────────────────────────────╮
--  │ 显示当前 context                                                             │
--  │ https://github.com/haringsrob/nvim_context_vt                                │
--  ╰──────────────────────────────────────────────────────────────────────────────╯
local cvt = require("nvim_context_vt")

cvt.setup({
  enabled = true,
  prefix = "",
  disable_ft = { "markdown", "yaml", "sh" },
  disable_virtual_lines = false,
  disable_virtual_lines_ft = { "yaml" },
  min_rows_ft = {},
  min_rows = 3,
})
