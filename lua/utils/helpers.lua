-----------------------------------------------------------------------
--                                                                   --
--                            工具函数                               --
--                         helper functions                          --
--                                                                   --
-----------------------------------------------------------------------
local M = {}

--- get nvim current mode string
---@return string
M.get_mode = function()
  local modes = {
    ["n"] = "NORMAL",
    ["no"] = "OP",
    ["nov"] = "OP",
    ["noV"] = "OP",
    ["no"] = "OP",
    ["niI"] = "NORMAL",
    ["niR"] = "NORMAL",
    ["niV"] = "NORMAL",
    ["v"] = "VISUAL",
    ["V"] = "V-LINE",
    [""] = "V-BLOCK",
    ["s"] = "SELECT",
    ["S"] = "SELECT",
    [""] = "V-BLOCK",
    ["i"] = "INSERT",
    ["ic"] = "INSERT",
    ["ix"] = "INSERT",
    ["R"] = "REPLACE",
    ["Rc"] = "REPLACE",
    ["Rv"] = "V-REPLACE",
    ["Rx"] = "REPLACE",
    ["c"] = "COMMAND",
    ["cv"] = "COMMAND",
    ["ce"] = "COMMAND",
    ["r"] = "ENTER",
    ["rm"] = "MORE",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    ["t"] = "TERMINAL",
    ["nt"] = "NORMAL",
    ["null"] = "NONE",
  }
  return modes[vim.api.nvim_get_mode().mode]
end

---isMacOS platform
---@return boolean
M.is_macos = (function()
  local uname = vim.loop.os_uname()
  local os = uname.sysname
  if os == "Darwin" then
    return true
  end
  return false
end)()

---open current file with some App
---@param app string like "vscode": open current file in vscode
M.open_file_with = function(app)
  if M.is_macos then
    vim.cmd(string.format([[silent !open -a %s %s]], app, vim.fn.expand("%:p")))
  else
    print("[helpers.open_file_by]: open command not suppourt")
  end
end

---open some app
---@param app string like "vscode": open vscode app
M.open_app = function(app)
  if M.is_macos then
    vim.cmd(string.format([[silent !open -a %s]], app))
  else
    print("[helpers.open_app]: open command not suppourt")
  end
end

---open current work dir in MacOS finder app
M.open_finder = function()
  if M.is_macos then
    vim.cmd([[silent !open .]])
  else
    print("[helpers.open_finder]: open command not suppourt")
  end
end

return M
