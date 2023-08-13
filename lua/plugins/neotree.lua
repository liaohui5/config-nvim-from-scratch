-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 侧边栏目录树                                                                 │
-- │ alternate: https://github.com/kyazdani42/nvim-tree.lua                       │
-- │ docs:  https://github.com/nvim-neo-tree/neo-tree.nvim                        │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
local keys = require("keybindings").neoTreeKeys()

-- {
--   -- 侧边栏文件目录树
--   "nvim-neo-tree/neo-tree.nvim",
--   branch = "v3.x",
--   event = "VeryLazy",
--   config = function()
--     require("plugins.neotree")
--   end,
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--     "nvim-tree/nvim-web-devicons",
--     "MunifTanjim/nui.nvim",
--   },
-- },

-- 事件处理
local event_handlers = {
  {
    event = "file_added",
    handler = function(filepath)
      -- 创建文件后立即编辑
      vim.cmd("silent edit " .. filepath)
    end,
  },
  {
    event = "file_deleted",
    handler = function(filepath)
      -- 遍历所有缓冲区 ID,并获取缓冲区的绝对路径,然后对比
      local bufids = vim.api.nvim_list_bufs()
      for _, id in ipairs(bufids) do
        local buf_path = vim.fn.expand(vim.api.nvim_buf_get_name(id))
        if buf_path == filepath then
          vim.cmd("silent bd " .. id)
        end
      end
    end,
  },
}

-- 监听打开/关闭事件设置barbar侧边距
local status, barApi = pcall(require, "barbar.api")
if status then
  table.insert(event_handlers, {
    event = "neo_tree_window_before_open",
    handler = function()
      barApi.set_offset(vim.g.file_explorer_width, string.rep(" ", 15) .. "Explorer")
    end,
  })
  table.insert(event_handlers, {
    event = "neo_tree_window_before_close",
    handler = function()
      barApi.set_offset(0)
    end,
  })
end

require("neo-tree").setup({
  close_if_last_window = true,
  popup_border_style = "single",
  enable_git_status = false,
  enable_diagnostics = false,
  hide_root_node = true,
  retain_hidden_root_indent = false, -- if the root node is hidden, keep the indentation anyhow.
  use_default_mappings = false, -- dont use default mappings
  source_selector = {
    winbar = true, -- toggle to show selector on winbar
  },
  default_component_configs = {
    container = {
      enable_character_fade = true,
    },
    indent = {
      indent_size = 2,
      padding = 1,
      with_markers = true,
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "",
      default = "",
    },
    git_status = {
      symbols = {
        added = "",
        modified = "~",
        deleted = "",
        renamed = "",
        untracked = "",
        ignored = "",
        unstaged = "",
        staged = "",
        conflict = "",
      },
    },
  },
  -- -- define some global commands, see `:h neo-tree-global-custom-commands`
  -- commands = {},
  window = {
    position = "left",
    width = vim.g.file_explorer_width,
    mappings = keys.top_window,
  },
  filesystem = {
    -- hijack_netrw_behavior = "open_default", -- open_default | open_current | disabled
    follow_current_file = {
      enabled = true,
    },
    use_libuv_file_watcher = true,
    filtered_items = {
      visible = true,
      hide_gitignored = true,
      hide_hidden = true, -- only works on Windows for hidden files/directories
      hide_dotfiles = false,
      hide_by_name = {
        ".DS_Store",
      },
      hide_by_pattern = {
        --"*.meta",
        --"*/src/*/tsconfig.json",
      },
      always_show = { -- remains visible even if other settings would normally hide it
        --".gitignored",
      },
      never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
        ".DS_Store",
        --"thumbs.db"
      },
      never_show_by_pattern = { -- uses glob style patterns
        --".null-ls_*",
      },
    },
    window = {
      mappings = keys.filesystem_window,
      fuzzy_finder_mappings = keys.filesystem_fuzzy_finder,
    },
    -- -- define some global commands, see `:h neo-tree-global-custom-commands`
    -- commands = {},
  },
  buffers = {
    follow_current_file = {
      enabled = true,
    },
    group_empty_dirs = false, -- when true, empty folders will be grouped together
    show_unloaded = true,
    window = {
      mappings = keys.buffers_window,
    },
  },
  git_status = {
    window = {
      mappings = keys.git_status_window,
    },
  },
  event_handlers = event_handlers,
})
