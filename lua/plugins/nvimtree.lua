-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 侧边栏目录树                                                                 │
-- │ docs: https://github.com/kyazdani42/nvim-tree.lua                            │
-- │ alternate:  https://github.com/nvim-neo-tree/neo-tree.nvim                   │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
local api = require("nvim-tree.api")
local bindkeys = require("keybindings").nvimtreeKeys()
local events = require("nvim-tree.events")
local nvimtree = require("nvim-tree")

-- {
--   -- 侧边栏文件目录树
--   "nvim-tree/nvim-tree.lua",
--   dependencies = { "nvim-tree/nvim-web-devicons" },
--   event = "VeryLazy",
--   config = function()
--     require("plugins.nvimtree")
--   end,
-- },

nvimtree.setup({
  on_attach = function(bufnr)
    -- default keybindings: https://github.com/nvim-tree/nvim-tree.lua/wiki/Migrating-To-on_attach
    local function bind(key, action, desc)
      vim.keymap.set("n", key, action, {
        desc = desc,
        buffer = bufnr,
        noremap = true,
        silent = true,
        nowait = true,
      })
    end
    bindkeys(bind, api)
  end,
  update_focused_file = {
    enable = true, -- 打开目录树时, 自动移动到当前文件为止
    update_root = true, -- 切换 session 自动更新
  },
  filesystem_watchers = {
    -- 文件变动检测每 100ms 检测一次
    enable = true,
    debounce_delay = 100,
  },
  actions = {
    use_system_clipboard = true,
    open_file = {
      resize_window = false,
    },
  },
  view = {
    -- 视图
    number = false,
    relativenumber = false,
    width = vim.g.file_explorer_width,
    signcolumn = "yes",
    side = "left",
  },
  renderer = {
    root_folder_label = false,
    indent_width = 2, -- 缩进宽度
    indent_markers = {
      -- 缩进线是否显示
      enable = true,
    },
    icons = {
      -- 图标: 显示哪些图标
      show = {
        file = true,
        folder = true,
        folder_arrow = false,
        modified = true,
        git = false,
      },
    },
  },
  git = {
    -- 禁止侧边栏使用 git
    enable = false,
  },
  filters = {
    -- 过滤哪些文件不要显示
    dotfiles = false,
    git_clean = false,
    no_buffer = false,
    custom = { ".DS_Store", ".git" }, -- 不需要显示的文件
    exclude = {},
  },
})

-- 监听创建文件事件, 自动编辑这个文件
-- events api source code: https://github.com/nvim-tree/nvim-tree.lua/blob/master/lua/nvim-tree/events.lua
events.subscribe(events.Event.FileCreated, function(file)
  vim.cmd("silent edit " .. file.fname)
end)

-- 打开/关闭侧边栏设置标题栏左边距离: 使用 barbar api 设置侧边距离
-- 如果能安装了 neovim-session-manager 才执行
-- session 切换之后, 将 barbar 的 offset 设置为 0
local bar_api_ok, barApi = pcall(require, "barbar.api")
if bar_api_ok then
  -- 监听切换侧边栏打开/关闭状态事件
  events.subscribe(events.Event.TreeOpen, function()
    barApi.set_offset(vim.g.file_explorer_width + 1, string.rep(" ", 15) .. "Explorer")
  end)
  events.subscribe(events.Event.TreeClose, function()
    barApi.set_offset(0)
  end)
end

local session_ok, session = pcall(require, "session_manager.config")
if bar_api_ok and session_ok then
  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "SessionLoadPost",
    group = vim.api.nvim_create_augroup("close_filetree_on_session_changed", {
      clear = true,
    }),
    callback = function()
      barApi.set_offset(0)
    end,
  })
end
