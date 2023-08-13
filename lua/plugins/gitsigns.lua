-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │  文件 git 状态显示                                                           │
-- │  docs: https://github.com/lewis6991/gitsigns.nvim                            │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
require("gitsigns").setup({
  update_debounce = 300,
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
  },
  yadm = { enable = false },
  on_attach = function()
    require("keybindings").gitsignsKeys()
  end,
})
