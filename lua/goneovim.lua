-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                                   GoNeovim                                   │
-- │                  docs: https://github.com/akiyosi/goneovim                   │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
-- 设置GUI客户端字体
local function setGuiFont(fontFamily, fontSize, styleStyle)
  -- 设置字体格式: 字体名:字体大小:字体风格 -> Hack:h16:l
  -- 字体名: 如果有空格建议使用[[]]         -> [[Hack Nerd Font Mono]]
  -- 字体大小: h开头加一想要设置的数字      ->  Hack:h16
  -- 字体风格: https://doc.qt.io/qt-5/qfont.html#Weight-enum
  --     b    - 加粗                        -> Hack:h16:l
  --     sb   - 中等加粗                    -> Hack:h16:sb
  --     l    - 细体                        -> Hack:h16:b
  --     i    - 斜体                        -> Hack:h16:i
  --     w[n] - 自定义字体宽度              -> Hack:h16:w10
  local guifont = string.format("%s:h%s", fontFamily, fontSize or "15")
  if styleStyle == "b" or styleStyle == "sb" or styleStyle == "l" or styleStyle == "i" then
    guifont = guifont .. ":" .. styleStyle
  end
  vim.opt.guifont = guifont
end

-- 设置复制粘贴的快捷键
local function setKeybindings()
  local keymap = vim.api.nvim_set_keymap
  local option = { noremap = true, silent = true }
  keymap("v", "<D-c>", [["+y]], option) -- Copy
  keymap("n", "<D-v>", [["+gP]], option) -- Paste normal mode
  keymap("v", "<D-v>", [["+P]], option) -- Paste visual mode
  keymap("i", "<D-v>", [[<ESC>"+pA]], option) -- Paste insert mode
end

setGuiFont("JetBrainsMono Nerd Font Mono", "15", "l")
setKeybindings()
