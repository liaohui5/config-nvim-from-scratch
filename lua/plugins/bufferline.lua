-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 顶部标签页                                                                   │
-- │ docs: https://github.com/akinsho/bufferline.nvim                             │
-- │ https://github.com/romgrk/barbar.nvim                                        │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
local bufferline = require("bufferline")
local bufferlineUI = require("bufferline.ui")
local highlights = {
  -- https://github.com/akinsho/bufferline.nvim/blob/v3.1.0/doc/bufferline.txt#L742
  fill = {
    max_name_length = 18,
    bg = "#23241e",
  },
  offset_separator = {
    fg = "#23241e",
    bg = "#23241e",
  },
  background = {
    fg = "#49483e",
    bg = "#23241e",
  },
  close_button = {
    fg = "#49483e",
    bg = "#23241e",
  },
  close_button_selected = {
    fg = "#a6e22e",
    bg = "#272822",
  },
  buffer_selected = {
    fg = "#a6e22e",
    bold = true,
    italic = false,
  },
  separator = {
    fg = "#49483e",
    bg = "#272822",
  },
  indicator_selected = {
    fg = "#272822",
    bg = "#272822",
  },
}

require("bufferline").setup({
  highlights = highlights,
  options = {
    mode = "buffers", -- "tabs" | "buffers"
    numbers = "none", -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
    close_command = "bdelete! %d",
    buffer_close_icon = "",
    modified_icon = "●",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    truncate_names = true, -- whether or not tab names should be truncated
    tab_size = 20,
    diagnostics = "nvim_lsp", -- false | "nvim_lsp" | "coc",
    diagnostics_update_in_insert = false,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer", -- o
        text_align = "center", -- "left" | "center" | "right"
        separator = true,
      },
    },
    color_icons = true,
    show_buffer_icons = true,
    show_buffer_default_icon = true,
    show_close_icon = false, -- right close button
    show_buffer_close_icons = true, -- tab close button
    show_tab_indicators = true,
    show_duplicate_prefix = true,
    persist_buffer_sort = true,
    separator_style = { "┃", "│" }, -- "slant" | "thick" | "thin" | { 'any', 'any' },
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    hover = { enabled = false },
    sort_by = "insert_at_end", -- 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
  },
})

-- 关闭其他标签
bufferline.closeOtherBuffers = function()
  local currentBuffer = vim.api.nvim_get_current_buf()
  local elements = bufferline.get_elements().elements
  for _, e in ipairs(elements) do
    if currentBuffer ~= e.id then
      vim.cmd(string.format("bdelete %s", e.id))
    end
  end
  bufferlineUI.refresh()
end

require("keybindings").bufferlineKeys(bufferline)
