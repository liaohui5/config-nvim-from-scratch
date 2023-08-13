------------------------------------------------------------------
-- 垂直显示缩进距离
-- github: https://github.com/lukas-reineke/indent-blankline.nvim
------------------------------------------------------------------
-- 禁止显示缩进
vim.g.indent_blankline_filetype_exclude = {
  "man",
  "help",
  "dashboard",
  "lspsagaoutline",
  "lspinfo",
  "packer",
  "lazy",
  "checkhealth",
}

require("indent_blankline").setup({
  space_char_blankline = " ",
  show_current_context_start = false,
  show_current_context = true,
  show_end_of_line = true,
})
