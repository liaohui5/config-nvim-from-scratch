-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │  侧边栏目录树                                                                │
-- │  docs: https://github.com/nvim-treesitter/nvim-treesitter                    │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
local keys = require("keybindings").treesitterKeys()

require("nvim-treesitter.configs").setup({
  sync_install = true,
  auto_install = true,
  ensure_installed = {
    -- 支持语法高亮的语言: https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
    "css",
    "bash",
    "scss",
    "lua",
    "yaml",
    "pug",
    "html",
    "javascript",
    "json",
    "markdown",
    "markdown_inline",
    "dot",
    "dockerfile",
    "sql",
    "tsx",
    "typescript",
    "toml",
    "vim",
    "vimdoc",
    "vue",
    "rust",
  },
  incremental_selection = {
    enable = true,
    keymaps = keys.incremental_selection,
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = false,
  },
  context_commentstring = {
    -- 识别语法注释: https://github.com/JoosepAlviste/nvim-ts-context-commentstring
    enable = true,
    enable_autocmd = false,
  },
  autotag = {
    -- xml标签自动闭合: https://github.com/windwp/nvim-ts-autotag
    enable = true,
  },
})

-- {
--   -- 自动转换字符串成模板字符串
--   "axelvc/template-string.nvim",
--   dependencies = "nvim-treesitter/nvim-treesitter",
--   config = function()
--     require("plugins.template-string")
--   end,
--   event = "VeryLazy",
--   cond = should_load,
-- },
-- {
--   -- 标签自动闭合
--   "windwp/nvim-ts-autotag",
--   dependencies = "nvim-treesitter/nvim-treesitter",
--   config = function()
--     require("plugins.nvim-ts-autotag")
--   end,
--   event = "VeryLazy",
--   cond = should_load,
-- },
