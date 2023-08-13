-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 换行/合并行                                                                  │
-- │ https://github.com/bennypowers/splitjoin.nvim                                │
-- │ https://github.com/AndrewRadev/splitjoin.vim                                 │
-- │ https://github.com/Wansmer/treesj                                            │
-- │ https://github.com/CKolkey/ts-node-action                                    │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
local bindkeys = require("keybindings").splitjoinKeys

-- splitjoin.nvim
local status, splitjoin = pcall(require, "splitjoin")
if status then
  splitjoin.setup()
  bindkeys("splitjoin.nvim")
  return
end

-- treesj
local status2, tsj = pcall(require, "treesj")
if status2 then
  tsj.setup({ use_default_keymaps = false })
  bindkeys("treesj")
  return
end
