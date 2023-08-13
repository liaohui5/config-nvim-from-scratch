-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ neovide 客户端配置                                                           │
-- │ docs: https://neovide.dev/configuration.html#configuration                   │
-- │ github: https://github.com/neovide/neovide                                   │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
-- 设置 neovide 选项
local function setNeovideOptions()
  local neovide_settings = {
    -- neovide_cursor_vfx_mode      = "",    -- ""取消光标动画效果
    -- neovide_transparency         = 0.5,   -- 透明度
    neovide_cursor_animation_length = 0, -- 0禁用动画
    neovide_fullscreen = false, -- 全屏打开
    neovide_remember_window_size = true, -- 记住之前的大小
    neovide_input_macos_alt_is_meta = true, -- 将 meta 映射到 alt
    neovide_input_use_logo = true, -- macos only
  }
  for k, v in pairs(neovide_settings) do
    vim.g[k] = v
  end
end

-- 设置字体
-- https://neovide.dev/configuration.html#font
local function setGuiFont(font, fontSize, options)
  local strfmt = string.format
  local ff = font or "JetBrainsMono Nerd Font Mono"
  local fs = fontSize or 16
  local op = options or { b = false, i = false, e = "antialias", h = "full" }
  local guitfont = strfmt("%s:h%s", ff, fs)
  if op.b then
    guitfont = strfmt("%s:b", guitfont)
  end
  if op.i then
    guitfont = strfmt("%s:i", guitfont)
  end
  vim.opt.guifont = strfmt("%s:#e-%s:#h-%s", guitfont, op.e, op.h)
end

-- 绑定 neovide 快捷键
local function setKeybindings()
  local keymap = vim.api.nvim_set_keymap
  local option = { noremap = true, silent = true }
  keymap("v", "<D-c>", "\"+y", option) -- Copy
  keymap("n", "<D-v>", "\"+P", option) -- Paste normal mode
  keymap("v", "<D-v>", "\"+P", option) -- Paste visual mode
  keymap("c", "<D-v>", "<c-R>+", option) -- Paste command mode
  keymap("i", "<D-v>", "<ESC>\"+PA", option) -- Paste insert mode
end

-- 调用执行
setNeovideOptions()
setGuiFont("JetBrainsMono Nerd Font Mono", 16, {
  e = "subpixelantialias",
  h = "slight",
})
setKeybindings()
