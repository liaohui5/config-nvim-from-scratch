--  ╭──────────────────────────────────────────────────────────────────────────────╮
--  │ 快速启动vite服务, 类似 VSCode LiveServer 插件效果                            │
--  │ https://github.com/liaohui5/vite-server.nvim                                 │
--  ╰──────────────────────────────────────────────────────────────────────────────╯
local vs = require("vite-server")
local ok, session = pcall(require, "session_manager.config")

if ok then
  -- 如果能安装了 neovim-session-manager 才执行
  -- 切换 session 后, 停止运行 vite-server
  local group = vim.api.nvim_create_augroup("stop_vite_server_on_session_changed", {
    clear = true,
  })
  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "SessionLoadPost",
    group = group,
    callback = function()
      if vs.is_started then
        vs.stop()
      end
    end,
  })
end

vs.setup({
  vite_cli_opts = {
    port = 9988,
    strictPort = false,
  },
  show_cmd = true,
})

local actions = {
  start_server = vs.start,
  stop_server = vs.stop,
  start_in_cwd = function()
    vs.start(vim.fn.getcwd())
  end,
}

require("keybindings").viteServerKeys(actions)
