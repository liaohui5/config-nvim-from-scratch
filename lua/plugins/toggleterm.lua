-- ╭──────────────────────────────────────────────────────────────────────────────────╮
-- │ 切换命令行                                                                       │
-- │ docs: https://github.com/akinsho/toggleterm.nvim                                 │
-- ╰──────────────────────────────────────────────────────────────────────────────────╯
-- ╭──────────────────────────────────────────────────────────────────────────────────╮
-- │ Terminal API                                                                     │
-- │ https://github.com/akinsho/toggleterm.nvim/blob/main/lua/toggleterm/terminal.lua │
-- ╰──────────────────────────────────────────────────────────────────────────────────╯
-- new      : 创建新的 terminal 实例
-- toggle   : 切换 terminal 实例显示/隐藏
-- is_open  : 获取 terminal 实例是否显示
-- open     : 显示 terminal 实例
-- close    : 隐藏 terminal 实例
-- shutdown : 退出(Ctrl+d) terminal 实例进程
local toggleterm = require("toggleterm")
local Terminal = require("toggleterm.terminal").Terminal
local plugins = {}
local float_opts = {
  border = "single", -- 浮动终端样式: single | double | shadow | curved
  width = 160, -- 全屏(width & height: 设置一个比较大的数字就会全屏显示)
  height = 40,
  winblend = 1,
}

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 集成插件注意:                                                                │
-- │  如果需要缓存终端实例, 就直接 Terminal:new({}) 如果不需要缓存实例            │
-- │  而是每次刷新, 就必须用方法, 每次执行都返回一个新的实例                      │
-- │  有的插件需要缓存: 比如 zellij / tmux 这种(不依赖执行目录)                   │
-- │  有的插件不能缓存: 比如 lazygit/ vifm 因为他是依赖执行目录的, 如果           │
-- │  没有强制刷新的话, 那么切换 session 之后, vifm 还是在原来的目录,而           │
-- │  不是当前 session 的目录                                                     │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
local function createTerminal(cmd)
  return Terminal:new({
    cmd = cmd,
    hidden = true,
    direction = "float",
    float_opts = float_opts,
  })
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 集成 lazygit                                                                 │
-- │ https://github.com/jesseduffield/lazygit                                     │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
plugins.lazygit = function()
  return createTerminal("lazygit")
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 集成 tig                                                                     │
-- │ https://github.com/jonas/tig                                                 │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
-- plugins.tig = function()
--   return createTerminal("tig")
-- end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 集成 vifm 终端文件管理器                                                     │
-- │ https://github.com/vifm/vifm                                                 │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
plugins.vifm = function()
  local buffPath = vim.fn.expand("%:p:h")
  local rootPath = vim.fn.getcwd()
  local commands = string.format("vifm %s %s", buffPath, rootPath)
  return createTerminal(commands)
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 集成 joshuto 终端文件管理器                                                  │
-- │ https://github.com/kamiyaa/joshuto                                           │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
plugins.joshuto = function(in_buf_path)
  local open_path = vim.fn.getcwd()
  if in_buf_path then
    open_path = string.format("joshuto %s", vim.fn.expand("%:p:h"))
  end
  return createTerminal(string.format("joshuto %s", open_path))
end

-- actions
local actions = {
  toggle_lazygit = function()
    plugins.lazygit():toggle()
  end,
  toggle_joshuto_in_project_root = function()
    plugins.joshuto(false):toggle()
  end,
  toggle_joshuto_in_current_buf = function()
    plugins.joshuto(true):toggle()
  end,
  toggle_vifm = function()
    plugins.vifm():toggle()
  end,
}

local keys = require("keybindings").toggletermKeys(actions)
toggleterm.setup({
  -- on_open           = function() end
  -- on_close          = function() end
  -- on_stdout         = function() end
  -- on_stderr         = function() end
  -- on_exit           = function() end
  -- shell             = vim.o.shell, -- 打开终端使用的shell: 不建议修改, 默认使用系统默认的 shell
  open_mapping = keys,
  hide_numbers = true, -- 打开的终端中是否要隐藏行号
  shade_terminals = false, -- 是否添加阴影
  persist_size = false, -- 是否保存上一次打开时的尺寸
  start_in_insert = true, -- 打开终端是 insert 模式
  shading_factor = 1, -- 打开终端的背景颜色(1:暗色 3:亮色)
  insert_mappings = true, -- 插入模式是否应用快捷键
  terminal_mappings = true, -- 在终端中是否应用快捷键
  persist_mode = false, -- 记住进入终端时vim的模式
  direction = "horizontal", -- 终端打开方式 vertical | horizontal | tab | float
  float_opts = float_opts,
  close_on_exit = true, -- close the terminal window when the process exits
  auto_scroll = true, -- automatically scroll to the bottom on terminal output
  size = function(term) -- 非浮动终端的大小
    if term.direction == "horizontal" then
      return 18
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
})
