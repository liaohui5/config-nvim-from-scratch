--  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .-----------------. .----------------.
--  | .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. |
--  | |     ____     | || |   ______     | || |  _________   | || |     _____    | || |     ____     | || | ____  _____  | || |    _______   | |
--  | |   .'    `.   | || |  |_   __ \   | || | |  _   _  |  | || |    |_   _|   | || |   .'    `.   | || ||_   \|_   _| | || |   /  ___  |  | |
--  | |  /  .--.  \  | || |    | |__) |  | || | |_/ | | \_|  | || |      | |     | || |  /  .--.  \  | || |  |   \ | |   | || |  |  (__ \_|  | |
--  | |  | |    | |  | || |    |  ___/   | || |     | |      | || |      | |     | || |  | |    | |  | || |  | |\ \| |   | || |   '.___`-.   | |
--  | |  \  `--'  /  | || |   _| |_      | || |    _| |_     | || |     _| |_    | || |  \  `--'  /  | || | _| |_\   |_  | || |  |`\____) |  | |
--  | |   `.____.'   | || |  |_____|     | || |   |_____|    | || |    |_____|   | || |   `.____.'   | || ||_____|\____| | || |  |_______.'  | |
--  | |              | || |              | || |              | || |              | || |              | || |              | || |              | |
--  | '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' |
--   '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'
--  ╭──────────────────────────────────────────────────────────────────────────────╮
--  │ 设置 neovim 的配置选项                                                       │
--  │ 在线参考中文手册:https://yianwillis.github.io/vimcdoc/doc/help.html          │
--  ╰──────────────────────────────────────────────────────────────────────────────╯
-- stylua: ignore
local function set_nvim_options()
  vim.opt.showmode       = false                        -- 是否在命令行位置显示当前 mode
  vim.opt.compatible     = false                        -- 缺省vi兼容模式,不能用退格.设置为不兼容模式
  vim.opt.title          = true                         -- 显示 title
  vim.opt.titlestring    = "%F - nvim"                  -- 窗口 title 显示内容
  vim.opt.cursorline     = true                         -- 高亮当前行
  vim.opt.clipboard      = "unnamedplus"                -- 使用系统粘贴板
  vim.opt.updatetime     = 100                          -- 更新间隔时间(ms), 比如按下 <Leader> 键后没有再
  vim.opt.timeoutlen     = 300                          -- 按其他键多久后自动取消 <Leader>, 不需要太快否则会频繁触发 which-key
  vim.opt.signcolumn     = "yes"                        -- 显示图标栏
  vim.opt.undofile       = true                         -- 开启撤销永久化
  vim.opt.laststatus     = 3                            -- 命令行状态
  vim.opt.cmdheight      = 1                            -- 底部命令行的高度为1
  vim.opt.ruler          = false                        -- 底部的行号等显示
  vim.opt.number         = true                         -- 显示行号
  vim.opt.relativenumber = false                        -- 相对当前行的行号
  vim.opt.numberwidth    = 2                            -- 行号左边符号栏的宽度 default: 4
  vim.opt.wrap           = false                        -- 不自动换行显示
  vim.opt.encoding       = "utf-8"                      -- 设置文件编码
  vim.opt.fileencodings  = "utf-8"                      -- 设置文件编码
  vim.opt.fileencoding   = "utf-8"                      -- 设置文件编码
  vim.opt.termencoding   = "utf-8"                      -- 设置文件编码
  vim.opt.autoread       = true                         -- 自动读取
  vim.opt.autowrite      = true                         -- 自动保存
  vim.opt.autowriteall   = true                         -- 自动保存
  vim.opt.splitbelow     = true                         -- 允许上下拆分窗口
  vim.opt.splitright     = true                         -- 允许左右拆分窗口
  vim.opt.termguicolors  = true                         -- terminal 颜色
  vim.opt.undofile       = true                         -- 允许撤回文件
  vim.opt.hlsearch       = true                         -- 搜索时高亮匹配到的字符
  vim.opt.wrapscan       = true                         -- 扫描到文件两端时重新搜索
  vim.opt.smartcase      = true                         -- 搜索时候区分大小写(有大写就区分, 没有就不区分)
  vim.opt.hidden         = true                         -- hidden
  vim.opt.swapfile       = false                        -- 不创建 swap 文件
  vim.opt.writebackup    = false                        -- 不创建备份文件
  vim.opt.autochdir      = false                        -- 自动切换当前目录为当前文件所在的目录
  vim.opt.showmatch      = true                         -- 当输入一个左括号时自动匹配右括号
  vim.opt.fillchars      = "eob: "                      -- 影藏空白区域~符号
  vim.opt.foldlevel      = 99                           -- 打开文件时,不要自动折叠
  vim.opt.foldlevelstart = 99                           -- 打开文件时,不要自动折叠
  vim.opt.foldenable     = true                         -- 开启折叠功能
  vim.opt.splitbelow     = true                         -- 在底部打开上下分割的窗口
  vim.opt.splitright     = true                         -- 在右边打开左右分割的窗口
  vim.opt.spell          = false                        -- 是否开启单词检查
  vim.opt.spelllang      = "en"                         -- 开启单词检查后, 检查的语言
  vim.opt.undolevels     = 99                           -- 最多可以撤销的次数
  vim.opt.autoindent     = true                         -- 新的行自动缩进
  vim.opt.smartindent    = false                        -- 根据语法自动缩进(使用 treesitter)
  vim.opt.foldmethod     = "expr"                       -- 根据缩进折叠 indent | expr | manual
  vim.opt.foldexpr       = "nvim_treesitter#foldexpr()" -- 使用 treesitter 来折叠, foldmethod 必须为 expr
  vim.opt.expandtab      = true                         -- 将 tab 转空格
  vim.opt.smarttab       = true                         -- 插入 <Tab> 时使用 shiftwidth 选项
  vim.opt.shiftwidth     = 2                            -- (自动) 缩进使用的步进单位,以空白数目计
  vim.opt.tabstop        = 2                            -- <Tab> 在文件里使用的空格数
  vim.opt.softtabstop    = 2                            -- 编辑时 <Tab> 使用的空格数
  vim.opt.list           = false                        -- 是否显示空白符号
  vim.opt.listchars      = {                            -- 空白字符显示
    tab = "↔ ",
    eol = "↩",
    space = ".",
    extends = "◀",
    precedes = "▶",
  }
end

-- 设置内置选项
set_nvim_options()

-- 禁止自动匹配高亮括号
vim.g.loaded_matchparen = false

-- 设置侧边栏文件目录树的宽度
vim.g.file_explorer_width = 38

-- 是否已经覆盖过高亮颜色
vim.g.override_highlight_executed = 0

-- 加载 snippets 目录
vim.g.snippets_save_dir = "snippets"

-- 是否加载不太常用的插件
vim.g.load_unpopular_plugins = true
