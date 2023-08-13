-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 缩进美化                                                                     │
-- │ https://github.com/kevinhwang91/nvim-ufo                                     │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
local ufo = require("ufo")

ufo.setup({
  fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = ("  fold %d lines "):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
      local chunkText = chunk[1]
      local chunkWidth = vim.fn.strdisplaywidth(chunkText)
      if targetWidth > curWidth + chunkWidth then
        table.insert(newVirtText, chunk)
      else
        chunkText = truncate(chunkText, targetWidth - curWidth)
        local hlGroup = chunk[2]
        table.insert(newVirtText, { chunkText, hlGroup })
        chunkWidth = vim.fn.strdisplaywidth(chunkText)
        -- str width returned from truncate() may less than 2nd argument, need padding
        if curWidth + chunkWidth < targetWidth then
          suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
        end
        break
      end
      curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, "MoreMsg" })
    return newVirtText
  end,
  open_fold_hl_timeout = 150,
  preview = {
    win_config = {
      border = { "", "", "", "", "", "", "", "" }, -- 预览时不显示边框
      winhighlight = "Normal:Folded",
      winblend = 0,
    },
    mappings = {
      scrollU = "<c-u>",
      scrollD = "<c-d>",
    },
  },
  provider_selector = function()
    return "indent"
  end,
})

require("keybindings").ufoKeys(ufo)
