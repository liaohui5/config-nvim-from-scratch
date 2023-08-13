-------------------------------------------------------
-- ai 自动补全代码
-- https://github.com/jcdickinson/codeium.nvim
-------------------------------------------------------
local codeiumAuthKey = vim.fn.stdpath("config") .. "/codeium_auth_key.json"
require("codeium").setup({
  config_path = codeiumAuthKey,
})
