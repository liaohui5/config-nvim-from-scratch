-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │             _              _     _           _ _                             │
-- │            | | _____ _   _| |__ (_)_ __   __| (_)_ __   __ _ ___             │
-- │            | |/ / _ \ | | | '_ \| | '_ \ / _` | | '_ \ / _` / __|            │
-- │            |   <  __/ |_| | |_) | | | | | (_| | | | | | (_| \__ \            │
-- │            |_|\_\___|\__, |_.__/|_|_| |_|\__,_|_|_| |_|\__, |___/            │
-- │                   |___/                             |___/                    │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
---@diagnostic disable
-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                         快捷键配置 & 快捷键菜单配置                          │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
local wk = require("which-key")
local function createBindKeyOpts(mode)
  return {
    mode = mode,
    noremap = true,
    silent = true,
    noawait = true,
  }
end
local normalModeOpts = createBindKeyOpts("n")
local visualModeOpts = createBindKeyOpts("v")
local operateModeOpts = createBindKeyOpts("o")
local commandModeOpts = createBindKeyOpts("c")
local keybindings = {
  -- 每个插件需要的按键绑定都是 function, { neogenKeys: function end }
  -- 这样的话就可以按需加载: 对应的插件加载对应插件的快捷键, 就可以随时
  -- 同步安装/卸载插件, 不影响其他插件, 也无需改对应的文件, 直接管理对应
  -- 插件就可以了
}

--  ╭──────────────────────────────────────────────────────────────────────────────╮
--  │                             静态服务 vite server                             │
--  ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.viteServerKeys = function(actions)
  wk.register({
    ["<leader>v"] = {
      name = "+ViteServer",
      s = {
        actions.start_server,
        "start server current directory",
      },
      q = {
        actions.stop_server,
        "stop vite server",
      },
      S = {
        actions.start_in_cwd,
        "start vite server project root directory",
      },
    },
  }, normalModeOpts)
end

--  ╭──────────────────────────────────────────────────────────────────────────────╮
--  │                               切换 colorscheme                               │
--  ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.base16Keys = function(setColorScheme)
  wk.register({
    ["<leader>tc"] = {
      setColorScheme,
      "toggle colorscheme",
    },
  }, normalModeOpts)
end

--  ╭──────────────────────────────────────────────────────────────────────────────╮
--  │                                 分割/合并行                                  │
--  ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.splitjoinKeys = function(plugin_name)
  local plugin_keybindings = {
    ["splitjoin.vim"] = { -- default
      ["gJ"] = { nil, "join line" },
      ["gS"] = { nil, "split line" },
    },
    ["splitjoin.nvim"] = {
      ["gJ"] = { "<cmd>lua require('splitjoin').join()<cr>", "join line" },
      ["gS"] = { "<cmd>lua require('splitjoin').split()<cr>", "split line" },
    },
    ["treesj"] = {
      ["gJ"] = { "<cmd>TSJJoin<cr>", "join line" },
      ["gS"] = { "<cmd>TSJSplit<cr>", "split line" },
    },
  }
  local keys = plugin_keybindings[plugin_name]
  if keys then
    wk.register(keys, normalModeOpts)
  end
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                               ufo 缩进美化插件                               │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.ufoKeys = function(ufo)
  local previewFold = function()
    local winid = ufo.peekFoldedLinesUnderCursor()
    if not winid then
      vim.lsp.buf.hover()
    end
  end
  wk.register({
    ["zj"] = {
      ufo.goNextClosedFold,
      "next closed fold",
    },
    ["zk"] = {
      ufo.goPreviousClosedFold,
      "prev closed fold",
    },
    ["zJ"] = {
      function()
        ufo.goNextClosedFold()
        ufo.peekFoldedLinesUnderCursor()
      end,
      "preview next closed fold",
    },
    ["zK"] = {
      function()
        ufo.goPreviousClosedFold()
        ufo.peekFoldedLinesUnderCursor()
      end,
      "preview prev closed fold",
    },
    ["zR"] = {
      ufo.openAllFolds,
      "open all folds",
    },
    ["zM"] = {
      ufo.closeAllFolds,
      "close all folds",
    },
    ["zr"] = {
      ufo.openFoldsExceptKinds,
      "open more folds",
    },
    ["zm"] = {
      ufo.closeFoldsWith,
      "close more folds",
    },
    ["zp"] = {
      previewFold,
      "preview fold content",
    },
  }, normalModeOpts)
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                            Comment.nvim 注释插件                             │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.commentKeys = function(api)
  wk.register({
    ["<c-\\>"] = {
      "<Plug>(comment_toggle_linewise_current)",
      "toggle comment",
    },
  }, normalModeOpts)
  wk.register({
    ["<c-\\>"] = {
      "<Plug>(comment_toggle_linewise_visual)<c-c>gv-gv",
      "toggle comment in selection",
    },
  }, visualModeOpts)
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                                 特殊块级注释                                 │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.commentBoxKeys = function()
  local commentBoxKeys = {
    ["<leader>cb"] = {
      name = "+CommentBlocks",
      ["1"] = {
        [[<cmd>CBllbox<cr>]],
        "text:left length:fixed",
      },
      ["2"] = {
        [[<cmd>CBlcbox<cr>]],
        "text:center length:fixed",
      },
      ["3"] = {
        [[<cmd>CBlrbox<cr>]],
        "text:center length:fixed",
      },
      ["4"] = {
        [[<cmd>CBalbox<cr>]],
        "text:left length:auto",
      },
      ["5"] = {
        [[<cmd>CBacbox<cr>]],
        "text:center length:auto",
      },
      ["6"] = {
        [[<cmd>CBarbox<cr>]],
        "text:left length:auto",
      },
    },
  }
  wk.register(commentBoxKeys, normalModeOpts)
  wk.register(commentBoxKeys, visualModeOpts)
end

--  ╭──────────────────────────────────────────────────────────────────────────────╮
--  │                               根据代码生成注释                               │
--  ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.neogenKeys = function(showNeogenActionMenus)
  wk.register({
    ["<leader>cc"] = {
      showNeogenActionMenus,
      "auto generate comments",
    },
  }, normalModeOpts)
end

--  ╭──────────────────────────────────────────────────────────────────────────────╮
--  │                             refactoring 重构工具                             │
--  ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.refactoringKeys = function(refactoring)
  wk.register({
    ["<leader>rf"] = {
      refactoring.select_refactor,
      "show refactoring actions",
    },
    ["<leader>cl"] = {
      refactoring.debug.cleanup,
      "clear debug print var",
    },
  }, normalModeOpts)

  wk.register({
    ["<leader>rf"] = {
      refactoring.select_refactor,
      "show refactoring actions",
    },
    ["<leader>il"] = {
      refactoring.debug.print_var,
      "print var",
    },
  }, visualModeOpts)
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                                 预览markdown                                 │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.markdownPreviewKeys = function()
  wk.register({
    ["<leader>M"] = {
      name = "+Markdown",
      p = {
        "<cmd>MarkdownPreview<cr>",
        "start preview markdown server",
      },
      P = {
        "<cmd>MarkdownPreviewStop<cr>",
        "stop preview markdown server",
      },
    },
  }, normalModeOpts)
end

--  ╭──────────────────────────────────────────────────────────────────────────────╮
--  │                                leap 快速移动                                 │
--  ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.leapKeys = function(actions)
  for _, mode_opts in ipairs({ operateModeOpts, visualModeOpts, normalModeOpts }) do
    wk.register({
      ["<leader>ll"] = {
        actions.find_line,
        "leap to line",
      },
      t = {
        function()
          actions.find_ast_node("t")
        end,
        "leap to treesitter ast node",
      },
      f = {
        function()
          actions.find_char_before("f")
        end,
        "leap to string before",
      },
      s = {
        function()
          actions.find_char_after("s")
        end,
        "leap to string after",
      },
    }, mode_opts)
  end

  return {
    repeat_search = "<enter>",
    next_phase_one_target = "<enter>",
    next_target = { "<enter>", ";" },
    prev_target = { "<tab>", "," },
    next_group = "<space>",
    prev_group = "<tab>",
    multi_accept = "<enter>",
    multi_revert = "<backspace>",
  }
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                        nvim-surround 两边围绕字符操作                        │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.nvimSurroundKeys = function()
  return {
    normal = "dc",
    visual = "S",
    delete = "dr",
    change = "du",
  }
end

--  ╭──────────────────────────────────────────────────────────────────────────────╮
--  │                          link-visitor 快速打开链接                           │
--  ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.linkVisitorKeys = function(help_keybings)
  wk.register({
    ["<leader>ou"] = {
      "<cmd>VisitLinkNearCursor<cr>",
      "Open url in browser",
    },
    ["<leader>oU"] = {
      "<cmd>VisitLinkInBuffer<cr>",
      "Open buffer urls in browser",
    },
    ["<leader>lu"] = {
      "<cmd>VisitLinkInBuffer<cr>",
      "list url to open",
    },
    ["<leader>h"] = help_keybings, -- open help urls
  }, normalModeOpts)
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                           nvim-treesitter 语法高亮                           │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.treesitterKeys = function()
  wk.register({
    ["<leader>Pt"] = {
      name = "treesitter",
      i = {
        "<cmd>TSInstallInfo<cr>",
        "treesitter install info",
      },
      c = {
        "<cmd>TSConfigInfo<cr>",
        "treesitter config info",
      },
      m = {
        "<cmd>TSModuleInfo<cr>",
        "treesitter module info",
      },
      u = {
        "<cmd>TSUpdateSync<cr>",
        "upgrade treesitter modules",
      },
    },
  }, normalModeOpts)

  return {
    -- 快速选中内容
    incremental_selection = {
      node_incremental = "+", -- 扩大选区
      node_decremental = "_", -- 减少选区
    },
  }
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                                align 代码对齐                                │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.alignKeys = function(align)
  local options = { noremap = true, silent = true }
  vim.keymap.set("n", "gaw", function()
    align.operator(align.align_to_string, {
      is_pattern = false,
      reverse = true,
      preview = false,
    })
  end, options)
  vim.keymap.set("n", "gaa", function()
    align.operator(align.align_to_char, {
      is_pattern = false,
      reverse = true,
      preview = false,
    })
  end, options)
  wk.register({
    ["<leader>a"] = {
      name = "+Align",
      a = {
        "<cmd>lua require('align').align_to_string(false,true,false)<cr>",
        "align by string",
      },
      A = {
        "<cmd>lua require('align').align_to_char(1,true,false)<cr>",
        "align by char",
      },
      p = {
        "<cmd>lua require('align').align_to_string(false,true,true)<cr>",
        "align by string(preview)",
      },
      r = {
        "<cmd>lua require('align').align_to_string(true,true,true)<cr>",
        "align by string or pattern(preview)",
      },
    },
  }, visualModeOpts)
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                                    barbar                                    │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.barbarKeys = function()
  wk.register({
    ["<leader>bp"] = {
      "<cmd>BufferPick<cr>",
      "buffer pick",
    },
    ["<leader>qH"] = {
      "<cmd>BufferCloseBuffersLeft<cr>",
      "close left buffers",
    },
    ["<leader>qL"] = {
      "<cmd>BufferCloseBuffersRight<cr>",
      "close right buffers",
    },
    ["<leader>bt"] = {
      "<cmd>BufferPin<cr>",
      "toggle buffer pin status",
    },
    ["<leader>bd"] = {
      "<cmd>BufferClose<cr>",
      "close buffer",
    },
    ["<leader>bD"] = {
      "<cmd>BufferCloseAllButCurrentOrPinned<cr>",
      "close other buffers",
    },
    ["<leader>bh"] = {
      "<cmd>BufferMove<cr>",
      "move to left",
    },
    ["<leader>bl"] = {
      "<cmd>BufferMoveNext<cr>",
      "move to right",
    },
    ["<S-h>"] = {
      "<cmd>BufferPrevious<cr>",
      "previous tab",
    },
    ["<S-l>"] = {
      "<cmd>BufferNext<cr>",
      "next tab",
    },
  }, normalModeOpts)
end

--  ╭──────────────────────────────────────────────────────────────────────────────╮
--  │                                  bufferline                                  │
--  ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.bufferlineKeys = function(bufferline)
  wk.register({
    ["<leader>bp"] = {
      "<cmd>BufferLinePick<cr>",
      "buffer pick",
    },
    ["<leader>qH"] = {
      "<cmd>BufferLineCloseLeft<cr>",
      "close left buffers",
    },
    ["<leader>qL"] = {
      "<cmd>BufferLineCloseRight<cr>",
      "close right buffers",
    },
    ["<leader>bt"] = {
      "<cmd>BufferLineTogglePin<cr>",
      "toggle buffer pin status",
    },
    ["<leader>bd"] = {
      "<cmd>bdelete<cr>",
      "close buffer",
    },
    ["<leader>bD"] = {
      bufferline.closeOtherBuffers,
      "close other buffers",
    },
    ["<leader>bh"] = {
      "<cmd>BufferLineMovePrev<cr>",
      "move to left",
    },
    ["<leader>bl"] = {
      "<cmd>BufferLineMoveNext<cr>",
      "move to right",
    },
    ["<S-h>"] = {
      "<cmd>BufferLineCyclePrev<cr>",
      "previous tab",
    },
    ["<S-l>"] = {
      "<cmd>BufferLineCycleNext<cr>",
      "next tab",
    },
  }, normalModeOpts)
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                               formatter 格式化                               │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.gitsignsKeys = function()
  wk.register({
    ["<leader>g"] = {
      name = "Git",
      ["f"] = {
        "<cmd>Gitsigns refresh<cr>",
        "refresh gitsigns",
      },
      ["u"] = {
        "<cmd>Gitsigns undo_stage_hunk<cr>",
        "undo current hunk",
      },
      ["r"] = {
        "<cmd>Gitsigns reset_hunk<cr>",
        "reset current hunk",
      },
      ["R"] = {
        "<cmd>Gitsigns reset_buffer<cr>",
        "reset buffer all hunk",
      },
      ["s"] = {
        "<cmd>Gitsigns stage_hunk<cr>",
        "stage current hunk",
      },
      ["S"] = {
        "<cmd>Gitsigns stage_buffer<cr>",
        "stage buffer all hunk",
      },
      ["d"] = {
        "<cmd>Gitsigns diffthis<cr>",
        "diff hunks",
      },
      ["j"] = {
        "<cmd>Gitsigns next_hunk<cr>",
        "next hunk",
      },
      ["k"] = {
        "<cmd>Gitsigns prev_hunk<cr>",
        "previous hunk",
      },
    },
  }, normalModeOpts)
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                                 hop 快速移动                                 │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.hopKeys = function()
  -- 搜索字符
  nnoremap("s", "<cmd>HopChar2AC<cr>")
  nnoremap("S", "<cmd>HopChar2BC<cr>")

  -- 当前行内搜索字符: f向后搜索, F向前
  nnoremap("f", "<cmd>HopChar1CurrentLineAC<cr>")
  nnoremap("F", "<cmd>HopChar1CurrentLineBC<cr>")

  -- 在当前文件中搜索单词
  wk.register({
    ["<leader>jj"] = {
      "<cmd>HopChar1<cr>",
      "jump to character",
    },
    ["<leader>jl"] = {
      "<cmd>HopLine<cr>",
      "jump to line",
    },
    ["<leader>jw"] = {
      "<cmd>HopWordAC<cr>",
      "jump to word",
    },
    ["<leader>jW"] = {
      "<cmd>HopWordBC<cr>",
      "jump to word before cursor",
    },
  }, normalModeOpts)
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                                 cmp 自动完成                                 │
-- │       docs: https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings        │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.cmpKeys = function(actions)
  return {
    ["<c-o>"] = actions.open,
    ["<c-k>"] = actions.select_prev,
    ["<c-j>"] = actions.select_next,
    ["<c-e>"] = actions.close,
    ["<cr>"] = actions.enter,
    ["<c-h>"] = actions.jump_prev,
    ["<c-l>"] = actions.jump_next,
    ["<S-Tab>"] = actions.jump_prev,
    ["<Tab>"] = actions.super_tab,
  }
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                          nvim-spectre 搜索替换增强                           │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.spectreKeys = function()
  wk.register({
    ["<leader>rr"] = {
      -- 在当前文件中搜索/替换
      "<cmd>lua require('spectre').open_file_search()<cr>",
      "replace in buffer",
    },
    ["<leader>rp"] = {
      -- 打开全局搜索/替换
      "<cmd>lua require('spectre').open()<cr>",
      "replace in project",
    },
  }, normalModeOpts)

  wk.register({
    ["<leader>rr"] = {
      -- 在所有文件中搜索: 被选中单词
      "<esc><cmd>lua require('spectre').open_visual({select_word=true})<cr>",
      "replace selected in buffer",
    },
    ["<leader>rp"] = {
      -- 在所有文件中搜索: 被选中单词
      "<esc><cmd>lua require('spectre').open_visual({select_word=true})<cr>",
      "replace selected in buffer",
    },
  }, visualModeOpts)
end

--  ╭──────────────────────────────────────────────────────────────────────────────╮
--  │                         快速搜索替换 search-replace                          │
--  ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.searchReplaceKeys = function()
  wk.register({
    ["<leader>rr"] = {
      "<cmd>SearchReplaceSingleBufferOpen<cr>",
      "quick replace commands",
    },
    ["<leader>rw"] = {
      "<cmd>SearchReplaceSingleBufferCWord<cr>",
      "replace cursor word",
    },
    ["<leader>rW"] = {
      "<cmd>SearchReplaceSingleBufferCWORD<cr>",
      "replace cursor WORD",
    },
  }, normalModeOpts)

  wk.register({
    ["<leader>rr"] = {
      "<cmd>SearchReplaceWithinVisualSelection<cr>",
      "quick replace commands in selection",
    },
  }, visualModeOpts)
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                            neotree 侧边栏目录树                              │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.neoTreeKeys = function()
  wk.register({
    ["<c-e>"] = {
      "<cmd>Neotree toggle<cr>",
      "toggle file explorer",
    },
  }, normalModeOpts)
  return {
    -- :h neo-tree-mappings
    top_window = {
      ["<space>"] = "toggle_node",
      ["o"] = "open",
      ["<enter>"] = "open",
      ["<esc>"] = "revert_preview",
      ["P"] = { "toggle_preview", config = { use_float = true } },
      ["l"] = "focus_preview",
      ["S"] = "open_split",
      ["s"] = "open_vsplit",
      ["Z"] = "close_node",
      ["q"] = "close_window",
      ["R"] = "refresh",
      ["?"] = "show_help",
      ["<s-tab>"] = "prev_source",
      ["<tab>"] = "next_source",
    },
    filesystem_window = {
      ["/"] = "fuzzy_finder", -- filter_on_submit
      ["<c-x>"] = "clear_filter",
      ["<c-k>"] = "prev_git_modified",
      ["<c-j>"] = "next_git_modified",
      ["."] = "set_root",
      ["<bs>"] = "navigate_up",
      ["a"] = "add",
      ["A"] = "add_directory",
      ["x"] = "delete",
      ["r"] = "rename",
      ["y"] = "copy_to_clipboard",
      ["d"] = "cut_to_clipboard",
      ["p"] = "paste_from_clipboard",
      ["m"] = "move",
    },
    filesystem_fuzzy_finder = {
      ["<c-j>"] = "move_cursor_down",
      ["<c-k>"] = "move_cursor_up",
    },
    buffers_window = {
      ["bd"] = "buffer_delete",
      -- ["<bs>"] = "navigate_up",
    },
    git_status_window = {
      ["gu"] = "git_unstage_file",
      ["ga"] = "git_add_file",
      ["gA"] = "git_add_all",
      ["gr"] = "git_revert_file",
      ["gc"] = "git_commit",
      ["gp"] = "git_push",
    },
  }
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                            nvimtree 侧边栏目录树                             │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.nvimtreeKeys = function(api)
  wk.register({
    ["<c-e>"] = {
      "<cmd>NvimTreeToggle<cr>",
      "toggle file explorer",
    },
    ["<leader>ft"] = {
      "<cmd>NvimTreeToggle<cr>",
      "toggle file explorer",
    },
    ["<leader>Rt"] = {
      "<cmd>NvimTreeRefresh<cr>",
      "refresh file explorer",
    },
  }, normalModeOpts)

  return function(bind, api)
    bind("o", api.node.open.edit, "Open") -- 打开并编辑
    bind("<Enter>", api.node.open.edit, "Open") -- 打开并编辑
    bind("<Tab>", api.node.open.preview, "Open Preview") -- 预览内容(光标不会离开)
    bind("<c-Enter>", api.node.run.system, "System Open") -- 系统打开(相当于双击文件)
    bind("v", api.node.open.vertical, "Open: Vertical Split") -- 左右分屏打开编辑
    bind("s", api.node.open.horizontal, "Open: Horizontal Split") -- 上下分屏打开编辑
    bind(".", api.tree.toggle_hidden_filter, "Toggle Dotfiles") -- 切换隐藏文件是否可见
    bind("a", api.fs.create, "Create") -- 创建文件
    bind("r", api.fs.rename, "Rename") -- 重命名文件
    bind("x", api.fs.trash, "Trash") -- 移除文件到垃圾桶
    bind("X", api.fs.remove, "Delete") -- 直接删除
    bind("d", api.fs.cut, "Cut") -- 剪切文件
    bind("p", api.fs.paste, "Paste") -- 粘贴文件
    bind("yy", api.fs.copy.node, "Copy") -- 复制文件
    bind("yn", api.fs.copy.filename, "Copy Filename") -- 复制文件名
    bind("yp", api.fs.copy.relative_path, "Copy Relative Path") -- 复制相对路径
    bind("yP", api.fs.copy.absolute_path, "Copy Absolute Path") -- 复制绝对路径
    bind("?", api.tree.toggle_help, "Help") -- 切换帮助
    bind("I", api.node.show_info_popup, "Info") -- 查看文件信息(大小/路径/权限/最后修改时间等)
  end
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                           session管理工具                                    │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.sessionManagerKeys = function()
  -- 在退出编辑器之前 & 自动保存当前 session 状态
  wk.register({
    ["<leader>p"] = {
      name = "+Project",
      r = {
        "<cmd>SessionManager load_last_session<cr>",
        "load last session",
      },
      c = {
        "<cmd>SessionManager load_current_dir_session<cr>",
        "load current session",
      },
      p = {
        "<cmd>SessionManager load_session<cr>",
        "pick session",
      },
      d = {
        "<cmd>SessionManager delete_session<cr>",
        "delete sessions",
      },
      s = {
        "<cmd>SessionManager save_current_session<cr>",
        "save sessions",
      },
    },
  }, normalModeOpts)
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                              telescope 搜索文件                              │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.telescopeKeys = function(builtin, actions, themes)
  wk.register({
    ["<c-p>"] = {
      -- 搜索文件
      "<cmd>Telescope find_files<cr>",
      "search files",
    },
    ["<leader><leader>"] = {
      -- 搜索 nvim 命令
      "<cmd>Telescope commands<cr>",
      "search commands",
    },
    ["<leader>/"] = {
      -- 搜索字符串(当前项目)
      "<cmd>Telescope live_grep<cr>",
      "search in project",
    },
    ["<leader>?"] = {
      -- 搜索快捷键绑定
      "<cmd>Telescope keymaps<cr>",
      "search keymaps",
    },
    ["<leader>sf"] = {
      -- 搜索字符串(当前buffer)
      "<cmd>Telescope current_buffer_fuzzy_find<cr>",
      "fuzzy search in buffer",
    },
    ["<leader>sF"] = {
      -- 搜索字符串(当前buffer)
      "<cmd>Telescope oldfiles<cr>",
      "search recent fiels",
    },
    ["<leader>sp"] = {
      -- 搜索字符串(当前项目)
      "<cmd>Telescope live_grep<cr>",
      "fuzzy search in object",
    },
    ["<leader>sb"] = {
      -- 搜索buffers
      "<cmd>Telescope buffers<cr>",
      "search buffers",
    },
    ["<leader>sT"] = {
      -- 搜索 TODO
      "<cmd>TodoTelescope<cr>",
      "search todos",
    },
    ["<leader>sH"] = {
      -- 搜索vim高亮颜色
      "<cmd>Telescope highlights<cr>",
      "search highlights",
    },
    ["<leader>sm"] = {
      -- 搜索vim高亮颜色
      "<cmd>Telescope marks<cr>",
      "search vim marks",
    },
    ["<leader>so"] = {
      -- 搜索vim设置选项
      "<cmd>Telescope vim_options<cr>",
      "search vim options",
    },
    ["<c-o>"] = {
      -- 搜索当前符号引用(需要treesitter)
      "<cmd>Telescope treesitter<cr>",
      "search treesitter nodes in buffer",
    },
    ["<leader>sB"] = {
      -- 搜索书签(所有)
      "<cmd>Telescope vim_bookmarks all<cr>",
      "search bookmarks",
    },
    -- 搜索 buffers
    ["<leader>lb"] = {
      "<cmd>Telescope buffers<cr>",
      "list buffers",
    },
    ["<leader>bb"] = {
      "<cmd>Telescope buffers<cr>",
      "show all buffers",
    },
  }, normalModeOpts)

  return {
    i = {
      -- 在显示 telescope 输入框时, insert 模式的时候
      ["<c-j>"] = actions.move_selection_next,
      ["<c-k>"] = actions.move_selection_previous,
      ["<c-n>"] = actions.cycle_history_next,
      ["<c-p>"] = actions.cycle_history_prev,
    },
  }
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                          ctrl + x : 打开/关闭命令行                          │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.toggletermKeys = function(actions)
  wk.register({
    ["<leader>og"] = {
      actions.toggle_lazygit,
      "toggle lazygit",
    },
    ["<c-g>"] = {
      actions.toggle_lazygit,
      "toggle lazygit",
    },
    ["<c-n>"] = {
      actions.toggle_joshuto_in_project_root,
      "toggle joshuto file manager",
    },
    ["<leader><c-n>"] = {
      actions.toggle_joshuto_in_current_buf,
      "toggle joshuto file manager",
    },
    ["<leader>of"] = {
      actions.toggle_vifm,
      "toggle vifm file manager",
    },
    ["<leader><c-x>"] = {
      "<cmd>ToggleTermToggleAll<cr>",
      "toggle all terminals",
    },
  }, normalModeOpts)
  return "<c-x>" -- <cmd>ToggleTerm<cr>
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                                  mason 设置                                  │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.masonKeys = function()
  wk.register({
    ["<leader>Pm"] = {
      "<cmd>Mason<cr>",
      "Mason",
    },
  }, normalModeOpts)

  -- stylua: ignore
  return {
    toggle_package_expand   = "o",     -- 展开
    install_package         = "i",     -- 安装
    update_package          = "u",     -- 更新
    update_all_packages     = "U",     -- 更新所有
    check_package_version   = "c",     -- 检查版本
    check_outdated_packages = "C",     -- 检查所有
    uninstall_package       = "X",     -- 删除
    cancel_installation     = "<c-c>", -- 取消安装
    apply_language_filter   = "<c-f>", -- 筛选
  }
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                               lsp 回调函数设置                               │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.lspKeys = function(client, bufnr)
  -- 直接选中第一个, 跳到函数定义位置, 如果需要查看所有引用建议使用gd 快捷键
  local function goto_define()
    vim.lsp.buf.definition({
      on_list = function(options)
        vim.fn.setqflist({}, " ", options)
        vim.api.nvim_command("cfirst")
      end,
    })
  end

  local function format_buffer()
    -- 格式化当前buffer并且保存
    vim.lsp.buf.format()
    vim.cmd("silent confirm write")
  end

  wk.register({
    ["gt"] = {
      goto_define,
      "go to definition",
    },
    ["<leader>ff"] = {
      format_buffer,
      "format document",
    },
    ["<leader>rn"] = {
      vim.lsp.buf.rename,
      "rename symbol",
    },
  }, normalModeOpts)
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                            typescript lsp server                             │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.typescriptKeys = function()
  local function ts_auto_import()
    vim.schedule(function()
      vim.cmd("TypescriptAddMissingImports")
      vim.cmd("TypescriptRemoveUnused")
      vim.cmd("TypescriptOrganizeImports")
    end)
  end
  wk.register({
    ["<leader>ai"] = {
      ts_auto_import,
      "auto import",
    },
    ["<leader>rF"] = {
      "<cmd>TypescriptRenameFile<cr>",
      "rename file",
    },
    ["<leader>cA"] = {
      "<cmd>TypescriptFixAll<cr>",
      "fix all errors",
    },
  }, normalModeOpts)
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                            lspsaga 自定义插件设置                            │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.lspsagaKeys = function(actions)
  wk.register({
    ["<leader>e"] = {
      name = "+Errors",
      j = { -- 下一个错误
        "<cmd>Lspsaga diagnostic_jump_next<cr>",
        "next error",
      },
      k = { -- 上一个错误
        "<cmd>Lspsaga diagnostic_jump_prev<cr>",
        "previous error",
      },
    },
    ["gh"] = { -- 查看帮助文档
      "<cmd>Lspsaga hover_doc<cr>",
      "Lspsaga hover",
    },
    ["ge"] = { -- 查看当前代码诊断信息
      "<cmd>Lspsaga show_line_diagnostics<cr>",
      "Lspsaga show diagnostics",
    },
    ["gd"] = { -- 跳到函数定义位置
      "<cmd>Lspsaga finder<cr>",
      "Lspsaga finder",
    },
    ["gp"] = { -- 预览代码(也可以直接修改)
      "<cmd>Lspsaga peek_definition<cr>",
      "Lspsaga finder",
    },
    ["<leader>ca"] = { -- 快速修复
      "<cmd>Lspsaga code_action<cr>",
      "code action quickFix",
    },
    ["<leader>js"] = { -- 打开 outline
      "<cmd>Lspsaga outline<cr>",
      "jump to symbol in buffer",
    },
    ["<leader>ls"] = { -- 打开 outline
      "<cmd>Lspsaga outline<cr>",
      "list symbols",
    },
    ["<leader>ss"] = { -- 打开 outline
      "<cmd>Lspsaga outline<cr>",
      "search outline in buffer",
    },
    ["<leader>rn"] = { -- 重命名变量
      "<cmd>Lspsaga rename<cr>",
      "rename symbol",
    },
  }, normalModeOpts)

  -- stylua: ignore
  return {
    scroll_preview = {
      scroll_down = "<c-u>",
      scroll_up   = "<c-d>",
    },
    finder = {
      jump_to = "o",
      edit    = { "e", "<cr>" },
      vsplit  = "s",
      split   = "i",
      tabe    = "t",
      quit    = { "q", "<c-c>", "<ESC>" },
    },
    definition = {
      edit   = "<c-c>o",
      vsplit = "<c-c>v",
      split  = "<c-c>i",
      tabe   = "<c-c>t",
      close  = "<Esc>",
      quit   = "<ESC>",
    },
    diagnostic = {
      exec_action = "o",
      go_action   = "g",
      quit        = "<ESC>",
    },
    code_action = {
      quit = "<ESC>",
      exec = "<cr>",
    },
    outline = {
      jump            = "o",
      expand_collapse = "u",
      quit            = "<ESC>",
    },
    rename = {
      quit    = "<c-c>",
      exec    = "<cr>",
      mark    = "x",
      confirm = "<cr>",
    },
  }
end

-- 内置 ui 增强
keybindings.dressingKeys = function()
  return {
    n = {
      ["<c-c>"] = "Close",
      ["<cr>"] = "Confirm",
    },
    i = {
      ["<c-c>"] = "Close",
      ["<cr>"] = "Confirm",
      ["<Up>"] = "HistoryPrev",
      ["<Down>"] = "HistoryNext",
    },
  }
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                                   dap 调试                                   │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.dapKeys = function(debug_close)
  local function dap_call_fn(fn)
    return string.format("<cmd>lua require('dap').%s()<cr>", fn)
  end

  wk.register({
    ["<leader>d"] = {
      name = "+Debugger",
      t = {
        dap_call_fn("toggle_breakpoint"),
        "toggle breakpoint(F9)",
      },
      s = {
        dap_call_fn("continue"),
        "start debug(F5)",
      },
      c = {
        dap_call_fn("continue"),
        "start debug(F5)",
      },
      i = {
        dap_call_fn("step_into"),
        "debug step in(F10)",
      },
      o = {
        dap_call_fn("step_out"),
        "debug step out(F11)",
      },
      O = {
        dap_call_fn("step_over"),
        "debug step over(F12)",
      },
    },
  })

  -- 与谷歌浏览器同步
  wk.register({
    ["<F5>"] = {
      dap_call_fn("continue"),
      "start debug(F5)",
    },
    ["<F6>"] = {
      debug_close,
      "close debug(F6)",
    },
    ["<F9>"] = {
      dap_call_fn("toggle_breakpoint"),
      "toggle breakpoint(F9)",
    },
    ["<F10>"] = {
      dap_call_fn("step_into"),
      "debug step in(F10)",
    },
    ["<F11>"] = {
      dap_call_fn("step_out"),
      "debug step out(F11)",
    },
    ["<F12>"] = {
      dap_call_fn("step_over"),
      "debug step over(F12)",
    },
  }, normalModeOpts)
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                                    dapUI                                     │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.dapUIKeys = function()
  return {
    mappings = {
      expand = { "o" },
      open = "<Enter>",
      remove = "d",
      edit = "e",
      repl = "r",
      toggle = "t",
    },
    floatingMappings = {
      close = { "q", "<Esc>" },
    },
  }
end

return keybindings
