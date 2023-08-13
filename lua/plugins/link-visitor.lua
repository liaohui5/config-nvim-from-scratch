--  ╭──────────────────────────────────────────────────────────────────────────────╮
--  │ 快速打开 url                                                                 │
--  │ docs: https://github.com/xiyaowong/link-visitor.nvim                         │
--  ╰──────────────────────────────────────────────────────────────────────────────╯
--[[
open_cmd: 指定用什么命令打开URL默认值就好
  win or wsl: cmd.exe /c start
  mac: open
  linux: xdg-open
--]]
local linkVisitor = require("link-visitor")

linkVisitor.setup({
  open_cmd = nil,
  silent = true,
  skip_confirmation = true,
})

local help_url_collection = {
  -- c = { -- <leader>hc -> 菜单按键,
  --   url = "要打开的url",
  --   desc = "快捷键描述",
  -- },
  c = {
    url = "https://yianwillis.github.io/vimcdoc/doc/help.html",
    desc = "chinese vim documentation",
  },
  n = {
    url = "https://neovim.io/doc",
    desc = "neovim documentation",
  },
  w = {
    url = "https://github.com/folke/which-key.nvim",
    desc = "which-key documentation",
  },
  i = {
    url = "https://github.com/neovim/neovim/issues",
    desc = "report neovim issue",
  },
  g = {
    url = "https://vim-adventures.com/",
    desc = "practice vim game",
  },
}

local help_keys = {
  name = "+Help",
}

for key, item in pairs(help_url_collection) do
  table.insert(help_keys, {
    [key] = {
      function()
        linkVisitor.visit(item.url)
      end,
      item.desc,
    },
  })
end

require("keybindings").linkVisitorKeys(help_keys)
