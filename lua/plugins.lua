---@diagnostic disable: different-requires
--  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .-----------------. .----------------.
-- | .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. |
-- | |   ______     | || |   _____      | || | _____  _____ | || |    ______    | || |     _____    | || | ____  _____  | || |    _______   | |
-- | |  |_   __ \   | || |  |_   _|     | || ||_   _||_   _|| || |  .' ___  |   | || |    |_   _|   | || ||_   \|_   _| | || |   /  ___  |  | |
-- | |    | |__) |  | || |    | |       | || |  | |    | |  | || | / .'   \_|   | || |      | |     | || |  |   \ | |   | || |  |  (__ \_|  | |
-- | |    |  ___/   | || |    | |   _   | || |  | '    ' |  | || | | |    ____  | || |      | |     | || |  | |\ \| |   | || |   '.___`-.   | |
-- | |   _| |_      | || |   _| |__/ |  | || |   \ `--' /   | || | \ `.___]  _| | || |     _| |_    | || | _| |_\   |_  | || |  |`\____) |  | |
-- | |  |_____|     | || |  |________|  | || |    `.__.'    | || |  `._____.'   | || |    |_____|   | || ||_____|\____| | || |  |_______.'  | |
-- | |              | || |              | || |              | || |              | || |              | || |              | || |              | |
-- | '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' |
--  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'
-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                                寻找想要的插件                                │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ https://vimawesome.com                                                       │
-- │ https://github.com/rockerBOO/awesome-neovim                                  │
-- │ https://github.com/altermo/vim-plugin-list                                   │
-- │ https://github.com/neovim/neovim/wiki/Related-projects#plugins               │
-- │ https://github.com/mhinz/vim-galore/blob/master/PLUGINS.md                   │
-- │ https://github.com/altermo/vim-plugin-list                                   │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
-- install neovim plugin manager lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
local plugins = {
  -- ╭────────────────────────────────────────────────────────────────────╮
  -- │                              UI 美化                               │
  -- ╰────────────────────────────────────────────────────────────────────╯
  {
    -- 工具函数
    "nvim-lua/plenary.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    -- 文件图标
    "nvim-tree/nvim-web-devicons",
    lazy = false,
    priority = 1000,
    config = function()
      require("plugins.nvim-web-devicons")
    end,
  },
  {
    -- 多颜色主题集合
    "RRethy/nvim-base16",
    event = "BufEnter",
    config = function()
      require("plugins.base16")
    end,
  },
  {
    -- 改进内部api的样式/select/input
    "stevearc/dressing.nvim",
    event = "BufEnter",
    config = function()
      require("plugins.dressing")
    end,
  },
  {
    -- 更好的编程语言语法高亮支持
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("plugins.nvim-treesitter")
    end,
  },
  {
    -- 开屏页
    "glepnir/dashboard-nvim",
    event = "VIMEnter",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("plugins.dashboard")
    end,
  },
  {
    -- git 状态显示
    "lewis6991/gitsigns.nvim",
    event = "VIMEnter",
    config = function()
      require("plugins.gitsigns")
    end,
  },
  {
    -- 侧边栏文件目录树
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    event = "VeryLazy",
    config = function()
      require("plugins.neotree")
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
  },

  -- {
  --   -- 缩进显示
  --   "lukas-reineke/indent-blankline.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("plugins.indent_blankline")
  --   end,
  -- },
  -- {
  --   -- 直接显示颜色代码对应的颜色
  --   "norcalli/nvim-colorizer.lua",
  --   event = "VeryLazy",
  --   config = function()
  --     require("plugins.colorizer")
  --   end,
  -- },
  {
    -- 折叠美化
    "kevinhwang91/nvim-ufo",
    event = "VeryLazy",
    config = function()
      require("plugins.nvim-ufo")
    end,
    dependencies = "kevinhwang91/promise-async",
  },
  {
    -- 顶部 buffer 栏目(类似bufferline)
    "romgrk/barbar.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("plugins.barbar")
    end,
    version = "^1.0.0",
    event = "BufEnter",
  },
  {
    -- 底部状态栏
    "nvim-lualine/lualine.nvim",
    config = function()
      require("plugins.lualine")
    end,
    event = "BufEnter",
    dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
  },
  -- ╭────────────────────────────────────────────────────────────────────╮
  -- │                              编辑增强                              │
  -- ╰────────────────────────────────────────────────────────────────────╯
  {
    -- 自动保存
    "Pocco81/auto-save.nvim",
    config = function()
      require("plugins.auto-save")
    end,
    event = "VeryLazy",
  },
  {
    -- 添加/删除/修改两边字符(用这个替代也可以: tpope/vim-surround)
    "kylechui/nvim-surround",
    config = function()
      require("plugins.nvim-surround")
    end,
    event = "VeryLazy",
  },
  {
    -- 自动输入匹配括号
    "windwp/nvim-autopairs",
    config = function()
      require("plugins.nvim-autopairs")
    end,
    event = "VeryLazy",
  },
  {
    -- 代码对齐
    "Vonr/align.nvim",
    config = function()
      require("plugins.align")
    end,
    event = "VeryLazy",
  },
  {
    -- 合并/切分当前行(3个都可以)
    -- "bennypowers/splitjoin.nvim"
    -- "AndrewRadev/splitjoin.vim"
    "Wansmer/treesj",
    config = function()
      require("plugins.splitjoin")
    end,
    event = "VeryLazy",
  },
  {
    -- 注释集成 treesitter
    "JoosepAlviste/nvim-ts-context-commentstring",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("plugins.nvim-treesitter")
    end,
  },
  {
    -- 快速注释插件
    "numToStr/Comment.nvim",
    event = "BufEnter",
    config = function()
      require("plugins.comment")
    end,
  },
  {
    -- 特殊注释块
    "LudoPinelli/comment-box.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.comment-box")
    end,
  },
  {
    -- 特殊注释高亮
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.todo-comments")
    end,
  },
  {
    -- 根据代码自动生成对应的注释工具
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    config = function()
      require("plugins.neogen")
    end,
  },
  -- ╭────────────────────────────────────────────────────────────────────╮
  -- │                              搜索替换                              │
  -- ╰────────────────────────────────────────────────────────────────────╯
  {
    -- 搜索文件/tab/书签
    "nvim-telescope/telescope.nvim",
    branch = "master",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufEnter",
    config = function()
      require("plugins.telescope")
    end,
  },
  {
    -- 快速移动类似 hop.nvim
    "ggandor/leap.nvim",
    dependencies = { "tpope/vim-repeat", "ggandor/leap-ast.nvim" },
    event = "BufEnter",
    config = function()
      require("plugins.leap")
    end,
  },
  {
    -- UI 操作替换(可多文件)
    -- 也可以使用不依赖外部命令的 "roobert/search-replace.nvim",
    "nvim-pack/nvim-spectre",
    event = "VeryLazy",
    config = function()
      require("plugins.spectre")
    end,
  },
  -- ╭────────────────────────────────────────────────────────────────────╮
  -- │                              特殊功能                              │
  -- ╰────────────────────────────────────────────────────────────────────╯
  {
    -- 启动速度记录
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    event = "VeryLazy",
  },
  {
    -- 重复上一个命令.增强(vimscript)
    "tpope/vim-repeat",
    event = "BufEnter",
  },
  {
    -- 自动切换输入法
    "keaising/im-select.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.im-select")
    end,
  },
  {
    -- 在浏览器中预览 markdown
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      require("plugins.markdown-preview")
    end,
    event = "VeryLazy",
  },
  {
    -- 快速打开 url
    "xiyaowong/link-visitor.nvim",
    config = function()
      require("plugins.link-visitor")
    end,
    event = "VeryLazy",
  },
  {
    "liaohui5/vite-server.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.vite-server")
    end,
  },
  {
    -- 命令行集成
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("plugins.toggleterm")
    end,
    event = "VeryLazy",
  },
  {
    -- 按键菜单
    "folke/which-key.nvim",
    config = function()
      require("plugins.which-key")
    end,
    event = "VeryLazy",
  },
  {
    -- session 管理
    "Shatur/neovim-session-manager",
    event = "VeryLazy",
    config = function()
      require("plugins.session-manager")
    end,
    dependencies = "nvim-lua/plenary.nvim",
  },
  {
    -- 代码重构工具
    "ThePrimeagen/refactoring.nvim",
    event = "BufEnter",
    config = function()
      require("plugins.refactoring")
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  -- ╭────────────────────────────────────────────────────────────────────╮
  -- │                              LSP配置                               │
  -- ╰────────────────────────────────────────────────────────────────────╯
  {
    -- LSP 服务自动配置
    "neovim/nvim-lspconfig",
    event = "BufEnter",
    config = function()
      require("lsp.lspconfig")
    end,
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "williamboman/mason.nvim",
      "jose-elias-alvarez/typescript.nvim",
    },
  },
  {
    -- 代码自动补全
    "hrsh7th/nvim-cmp",
    event = "LspAttach",
    config = function()
      require("lsp.cmp")
    end,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "rafamadriz/friendly-snippets",
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
      },
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-nvim-lua",
    },
  },
  {
    -- 代码格式化/语法检查
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
      require("lsp.null-ls")
    end,
  },
  {
    -- lsp 功能美化增强
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lsp.lspsaga")
    end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
}

-- ╭────────────────────────────────────────────────────────────────────╮
-- │                          lazy.nvim 配置                            │
-- ╰────────────────────────────────────────────────────────────────────╯
local lazy_options = {
  ui = { border = "single" },
  defaults = { lazy = true },
}
require("lazy").setup(plugins, lazy_options)
