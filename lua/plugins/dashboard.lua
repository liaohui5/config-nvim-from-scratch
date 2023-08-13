--  ╭──────────────────────────────────────────────────────────────────────────────╮
--  │ 开屏页插件                                                                   │
--  │ https://github.com/glepnir/dashboard-nvim                                    │
--  ╰──────────────────────────────────────────────────────────────────────────────╯
local db = require("dashboard")
local utils = require("dashboard.utils")

local function pad_right(str, len)
  while #str < len do
    str = str .. " "
  end
  return str
end

--- widths & paddings
local header_width = 55
local menus_width = header_width - 20
local header_pad_lines = 6
local menus_pad_lines = 5

--- header
local empty_line = pad_right("", header_width)
local header = {
  " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
  " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
  " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
  " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
  " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
  " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
}

for i = 1, header_pad_lines do
  table.insert(header, 1, empty_line)
  table.insert(header, empty_line)
end

--- footer
local states = utils.get_package_manager_stats()
local footer = {
  string.format("🚀 neovim installed %s packages", states.count),
}

for i = 1, menus_pad_lines do
  table.insert(footer, 1, empty_line)
end

--- middle menus
local menu_items = {
  -- menu item example:
  -- {
  -- 	icon = " ",
  -- 	icon_hl = "Title",
  -- 	desc = "Find File",
  -- 	desc_hl = "String",
  -- 	key = "b",
  -- 	keymap = "SPC f f",
  -- 	key_hl = "Number",
  -- 	action = "lua print(2)",
  -- },
  {
    icon = "󰥔",
    desc = "Load last session",
    key = "l",
    keymap = "SPC p r",
    action = "SessionManager load_last_session",
  },
  {
    icon = "",
    desc = "Pick session",
    key = "p",
    keymap = "SPC p p",
    action = "SessionManager load_session",
  },
  {
    icon = "󰆓",
    desc = "Save current session",
    key = "s",
    keymap = "SPC p s",
    action = "SessionManager save_current_session",
  },
  {
    icon = "",
    desc = "Find files",
    key = "f",
    keymap = "<c-p>",
    action = "Telescope find_files",
  },
  {
    icon = "",
    desc = "Recent files",
    key = "r",
    keymap = "SPC s F",
    action = "Telescope oldfiles",
  },
  {
    icon = "",
    desc = "Configuration",
    key = "c",
    keymap = "SPC o c",
    action = "edit $MYVIMRC",
  },
  {
    icon = "",
    desc = "Plugins",
    key = "P",
    keymap = "SPC P p",
    action = "Lazy",
  },
  {
    icon = "",
    desc = "Quit",
    key = "q",
    keymap = "<c-q>",
    action = "quitall",
  },
}

for _, menu in pairs(menu_items) do
  menu.icon_hl = "Title"
  menu.desc_hl = "String"
  menu.key_hl = "Number"
  menu.icon = menu.icon .. "  "
  menu.desc = pad_right(menu.desc, menus_width)
end

-- 启动 dashboard
db.setup({
  theme = "doom",
  config = {
    center = menu_items,
    header = header,
    footer = footer,
  },
})

-- 覆盖高亮
vim.api.nvim_set_hl(0, "DashboardHeader", {
  link = "TSFunction",
})
vim.api.nvim_set_hl(0, "DashboardFooter", {
  link = "Comment",
})
