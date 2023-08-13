-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │  自动保存文件                                                                │
-- │  docs: https://github.com/Pocco81/auto-save.nvim                             │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
local autosave = require("auto-save")
local utils = require("auto-save.utils.data")

autosave.setup({
  enabled = true,
  trigger_events = { "InsertLeave", "FocusLost" },
  write_all_buffers = false,
  debounce_delay = 1000, -- 1s
  execution_message = {
    cleaning_interval = 1200,
    message = function()
      return ("auto-save at: " .. vim.fn.strftime("%H:%M:%S"))
    end,
  },
  condition = function(buf)
    local disabled_buffers = {
      "NvimTree",
      "TelescopePrompt",
      "aerial",
      "spectre_panel",
    }
    local disabled_buftypes = {
      "prompt",
    }
    local modifiable = vim.fn.getbufvar(buf, "&modifiable")
    local filetype = vim.fn.getbufvar(buf, "&filetype")
    local buftype = vim.fn.getbufvar(buf, "&buftype")
    if
        modifiable == 1
        and utils.not_in(filetype, disabled_buffers)
        and utils.not_in(buftype, disabled_buftypes)
    then
      return true
    end
    return false
  end,
  callbacks = {
    enabling = nil,
    disabling = nil,
    before_saving = nil,
    after_saving = nil,
    before_asserting_save = nil,
  },
})
