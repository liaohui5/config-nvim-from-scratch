--  ╭──────────────────────────────────────────────────────────────────────────────╮
--  │ 替换内置UI/让命令行像VSCode一样在buffer中                                    │
--  │ github:https://github.com/folke/noice.nvim                                   │
--  ╰──────────────────────────────────────────────────────────────────────────────╯
require("noice").setup({
  presets = {
    command_palette = true,
    bottom_search = false,
    long_message_to_split = false,
    inc_rename = false,
  },
  notify = { enabled = false, },
  messages = { enabled = false },
  popupmenu = {
    enabled = true,
    backend = "cmp",
  },
  views = {
    cmdline_popup = {
      win_options = {
        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
      },
      position = {
        row = 5,
        col = "50%",
      },
      size = {
        width = 70,
        height = "auto",
      },
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "written",
        },
        opts = { skip = true },
      },
      {
        view = "notify",
        filter = { event = "msg_showmode" },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          kind = "search_count",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          kind = "",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "notify",
          kind = "",
        },
        opts = { skip = true },
      },
    },
  },
})
