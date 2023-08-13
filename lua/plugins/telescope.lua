-- │  搜索文件/buffer/字符串                                                                │
-- │  docs: https://github.com/nvim-telescope/telescope.nvim                                │
-- │  setup: https://github.com/nvim-telescope/telescope.nvim/blob/master/doc/telescope.txt │
-- │  plugins: https://github.com/nvim-telescope/telescope.nvim/wiki/Extensions             │
-- ╰────────────────────────────────────────────────────────────────────────────────────────╯
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local telescope = require("telescope")
local themes = require("telescope.themes")
local mappings = require("keybindings").telescopeKeys(builtin, actions, themes)

telescope.setup({
  defaults = {
    mappings = mappings, -- 快捷键
    selection_caret = " ", -- 选择指示图标
    prompt_prefix = "🔭 ", -- 输入框前缀
    prompt_title = false, -- 输入框标题
    border = true, -- 边框
    layout_strategy = "horizontal", -- 布局
    sorting_strategy = "ascending", -- 布局方式
    layout_config = {
      prompt_position = "top", -- 输入框位置
    },
    file_ignore_patterns = { -- 忽略目录
      "**node_modules",
      "**.git",
    },
  },
  pickers = {
    find_files = {
      prompt_title = false,
      previewer = false,
      find_command = {
        "fd", -- 需要安装命令: https://github.com/chinanf-boy/fd-zh
        "-H", -- -H: show hidden files
        "-I", -- -I: dont ignore `.gitignore` rules
        "--type",
        "file", -- --type file & symlink 仅显示文件和软连接,不显示目录
        "--type", -- 更多选项: https://github.com/chinanf-boy/fd-zh
        "symlink",
        "--strip-cwd-prefix",
      },
    },
  },
})

