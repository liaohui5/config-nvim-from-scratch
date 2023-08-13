-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ LSP 启动配置                                                                 │
-- │ docs:                                                                        │
-- │ https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion                 │
-- │ https://github.com/hrsh7th/nvim-cmp                                          │
-- │ https://github1s.com/hrsh7th/nvim-cmp/blob/HEAD/lua/cmp/config/default.lua   │
-- │ https://zjp-cn.github.io/neovim0.6-blogs/nvim/luasnip/doc-api.html           │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
local cmp = require("cmp")
local luasnip = require("luasnip")
local luasnip_vscode_loader = require("luasnip.loaders.from_vscode")
local context = require("cmp.config.context")
local devicons = require("nvim-web-devicons")
local lspkind, helpers = require("lsp.lspkind"), require("utils.helpers")
local api, fn, strfmt = vim.api, vim.fn, string.format
local config, preset = cmp.config, cmp.mapping.preset

-- 指定加载自定义 snippets 目录
luasnip_vscode_loader.lazy_load()
luasnip_vscode_loader.lazy_load({
  paths = { "./snippets" },
})

----------------------------------------
------------- 代码补全引擎 -------------
----------------------------------------
local setupConfig = {
  snippet = {
    -- 指定 snippets 引擎: https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
}

----------------------------------------
------------- 开启提示条件 -------------
----------------------------------------
setupConfig.enabled = function()
  -- 不能在注释内容中
  if context.in_treesitter_capture("comment") or context.in_syntax_group("Comment") then
    return false
  end

  -- 不能在输入框
  if api.nvim_buf_get_option(0, "buftype") == "prompt" then
    return false
  end

  -- 不能在录制模式 & 回放录制模式
  if vim.fn.reg_recording() ~= "" then
    return false
  end
  if vim.fn.reg_executing() ~= "" then
    return false
  end
  return true
end

----------------------------------------
------------- 提示来源配置 -------------
----------------------------------------
setupConfig.sources = config.sources({
  -- 找到更多的提示源: https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
  -- 建议不要太多, 很多事没用的信息, 提示源太多会影响速度
  { name = "luasnip" },
  { name = "nvim_lsp" },
  { name = "buffer" },
  { name = "nvim_lua" },
  { name = "path" },
  { name = "nvim_lsp_signature_help" },
  { name = "nvim_lsp_document_symbol" },
})

----------------------------------------
------------- 窗口样式配置 -------------
----------------------------------------
-- 给代码提示/代码文档窗口加上边框
-- https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/window.lua
setupConfig.window = {
  completion = config.window.bordered({
    scrollbar = false,
    winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
  }),
  documentation = config.window.bordered({
    scrollbar = false,
    winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
  }),
}

----------------------------------------
------------- 格式化配置 ---------------
----------------------------------------
setupConfig.formatting = {
  -- 格式化代码提示窗口菜单样式
  fields = { "kind", "abbr", "menu" },
  format = function(entry, item)
    -- 提示文件路径时, 显示文件图标
    if vim.tbl_contains({ "path" }, entry.source.name) then
      local icon, hlGroup = devicons.get_icon(entry:get_completion_item().label)
      if icon then
        item.kind = icon
        item.kind_hl_group = hlGroup
        return item
      end
    end

    local source_name = entry.source.name
    local menu = strfmt("[%s]", source_name)
    if string.lower(source_name) == "nvim_lsp" then
      menu = strfmt("[%s]", item.kind)
    end
    item.menu = menu
    item.kind = lspkind[item.kind] or item.kind
    return item
  end,
}

----------------------------------------
------------- 命令行设置 ---------------
----------------------------------------
local cmdline = cmp.setup.cmdline
local search_opts = {
  mapping = preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
}
cmdline("/", search_opts)
cmdline("?", search_opts)

-- 命令行命令补全
cmdline(":", {
  mapping = preset.cmdline(),
  sources = config.sources({
    { name = "cmdline" },
    { name = "path" },
  }),
})

----------------------------------------
------------- 快捷键绑定 ---------------
----------------------------------------
local feedkey = function(key, mode)
  api.nvim_feedkeys(api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local actions = {
  jump_prev = cmp.mapping(function()
    -- 跳到代码片段上一个位置
    if luasnip.jumpable(-1) then
      luasnip.jump(-1)
    end
  end),
  jump_next = cmp.mapping(function()
    -- 跳到代码片段下一个位置
    if luasnip.expand_or_locally_jumpable() then
      luasnip.expand_or_jump()
    end
  end),
  super_tab = cmp.mapping(function(fallback)
    -- 确定选择/展开&跳转代码片段/显示代码提示/tab
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expand_or_locally_jumpable() then
      luasnip.expand_or_jump()
    else
      fallback("<Tab>", "")
    end
  end),
  enter = cmp.mapping(function(fallback)
    -- 确定选中
    if cmp.visible() then
      cmp.confirm({ select = true })
    else
      fallback("<cr>", "")
    end
  end),
  open = cmp.mapping(function()
    -- 打开代码提示框
    cmp.complete()
  end, { "i", "c" }),
  close = cmp.mapping({
    -- 关闭代码提示框
    i = cmp.abort(),
    c = cmp.close(),
  }),
  select_prev = cmp.mapping(function()
    -- 选中上一个
    if cmp.visible() then
      cmp.select_prev_item()
    end
  end, { "i", "c" }),
  select_next = cmp.mapping(function()
    -- 选中下一个
    if cmp.visible() then
      cmp.select_next_item()
    end
  end, { "i", "c" }),
}
local keybindings = require("keybindings").cmpKeys(actions)
setupConfig.mapping = preset.insert(keybindings)

----------------------------------------
----------------- 启动 -----------------
----------------------------------------
cmp.setup(setupConfig)
