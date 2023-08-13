--[[
-----------------------------------------------------
-- 快速移动光标位置, 功能类似 vim-easymotion
-- github: https://github.com/ggandor/leap.nvim
-- 替代插件: https://github.com/phaazon/hop.nvim
-----------------------------------------------------
-- 通过 treesitter 代码ast节点来跳转/选中增强插件
-- github: https://github.com/ggandor/leap-ast.nvim
-----------------------------------------------------
leap 函数的参数:
  - offset: 在字符串 hello@ab#world 中搜索 "ab"
    -1: 代表光标停在 @ 字符的位置上
    0 : 代表光标停在 a 字符的位置上
    1 : 代表光标停在 b 字符的位置上
    2 : 代表光标停在 # 字符的位置上
  - targets: 在指定内容中搜索
  - target_windows: 在指定的窗口中搜索
https://github.com/ggandor/leap.nvim#calling-leap-with-custom-arguments
-----------------------------------------------------
设计理念: 跳到任意位置最多只要按4个按键(特殊情况最多 5 个按键)
使用公式: (搜索)
  1. s(启动键:也可能是其他启动按键)
  2. 要搜索的字符(2个)
  3. label(标记位置:有多个匹配的结果才会出现到 label)

使用公式: (选中)
  1. vs(启动键)
  2. 要搜索的字符(2个)
  3. label(标记位置:有多个匹配的结果才会出现到 label)

使用公式: (删除)
  1. ds(启动键)
  2. 要搜索的字符(2个)
  3. label(标记位置:有多个匹配的结果才会出现到 label)
-----------------------------------------------------
注意事项:
1. 匹配分组:
  如果是匹配结果特别多,超过了最大的labels(52个),
  他就会分组显示, 空格切换至下一个分组, tab切换到上一个tab

2. 多窗口启动: 默认按键中gs为启动键(global search),我这里取消了(用的很少)

3. 可以配合其他 Operator(dyc) 来使用
--]]
local helpers = require("utils.helpers")
local leap = require("leap")
local leap_ast = require("leap-ast")
local luasnip_status, luasnip = pcall(require, "luasnip")

-- 获取 leap_to_line 需要的数据
local function get_line_starts(winid)
  local wininfo = vim.fn.getwininfo(winid)[1]
  local cur_line = vim.fn.line(".")
  local targets = {}
  local lnum = wininfo.topline
  while lnum <= wininfo.botline do
    local fold_end = vim.fn.foldclosedend(lnum)
    if fold_end ~= -1 then
      lnum = fold_end + 1
    else
      if lnum ~= cur_line then
        table.insert(targets, { pos = { lnum, 1 } })
      end
      lnum = lnum + 1
    end
  end
  local cur_screen_row = vim.fn.screenpos(winid, cur_line, 1)["row"]
  local function screen_rows_from_cur(t)
    local t_screen_row = vim.fn.screenpos(winid, t.pos[1], t.pos[2])["row"]
    return math.abs(cur_screen_row - t_screen_row)
  end
  table.sort(targets, function(t1, t2)
    return screen_rows_from_cur(t1) < screen_rows_from_cur(t2)
  end)

  if #targets >= 1 then
    return targets
  end
end

-- 搜索窗口范围(仅当前窗口) winid: 当前窗口id
local winid = vim.api.nvim_get_current_win()

-- 创建搜索的方法
local function leap_proxy(leapMethod)
  return function(feedkey)
    if luasnip_status and luasnip.in_snippet() then
      -- 如果是在使用 snippets, 不要去查找字符
      vim.api.nvim_feedkeys(feedkey, "n", true)
      return
    end
    leapMethod()
  end
end

local actions = {
  -- 搜索抽象语法树节点(treesitter node)
  find_ast_node = leap_proxy(leap_ast.leap),

  -- 搜索字符(在搜索字符的最前位置停下)
  find_char_before = leap_proxy(function()
    leap.leap({
      offset = 0,
      target_windows = { winid },
    })
  end),

  -- 搜索字符(在搜索字符的最后位置停下)
  find_char_after = leap_proxy(function()
    leap.leap({
      offset = 1,
      target_windows = { winid },
    })
  end),

  -- 搜索行
  find_line = function()
    leap.leap({
      targets = get_line_starts(winid),
      target_windows = { winid },
    })
  end,
}

-----------------------------------------------------------
----- 初始化
-----------------------------------------------------------
local keys = require("keybindings").leapKeys(actions)

-- 启动
leap.setup({
  max_highlighted_traversal_targets = 10,
  max_phase_one_targets = nil,
  highlight_unlabeled_phase_one_targets = true,
  case_sensitive = false, -- 是否区分大小写
  special_keys = keys,    -- 操作
  equivalence_classes = { " \t\r\n" },
  -- 跳到指定位置显示的标记字符, 使用默认值
  -- safe_labels = {},
  -- labels      = {},
  -- substitute_chars = {},
})
