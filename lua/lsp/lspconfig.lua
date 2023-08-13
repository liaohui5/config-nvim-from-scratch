-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │  安装LSP服务器工具                                                           │
-- │  docs: https://github.com/williamboman/mason.nvim                            │
-- │  配置LSP服务器工具                                                           │
-- │  docs: https://github.com/neovim/nvim-lspconfig                              │
-- │  docs: https://github.com/williamboman/mason-lspconfig.nvim                  │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
local keybindings = require("keybindings")
local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local typescript = require("typescript")
local cmp_nvim_lsp = require('cmp_nvim_lsp')

-- 启动 mason_lspconfig 必须先启动 mason
mason.setup({
  keymaps = keybindings.masonKeys(),
  max_concurrent_installers = 5,
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

-- 先自动安装对应的 language-server
-- 安装服务: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
-- 具体配置: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {
  "lua_ls",
  "tsserver",
  "cssls",
  "cssmodules_ls",
  "volar",
  "html",
  "yamlls", -- yaml
  "taplo",  -- toml
  "emmet_ls",
  "jsonls",
  "bashls",
  "dockerls",
  "dotls",
  "sqlls",
  "vimls",
  "rust_analyzer",
  "clangd",
  "dockerls",
  "docker_compose_language_service",
  -- "tailwindcss",  -- tailwindcss
  -- "intelephense", -- PHP
  -- "pylsp",        -- Python
}
mason_lspconfig.setup({
  automatic_installation = true,
  ensure_installed = servers,
})
for _, item in ipairs(servers) do
  local server = lspconfig[item]
  -- local capabilities = vim.lsp.protocol.make_client_capabilities()
  local capabilities = cmp_nvim_lsp.default_capabilities();
  server.setup({
    capabilities = capabilities,
    on_attach = keybindings.lspKeys,
  })

  if item == "tsserver" then
    -- https://github.com/jose-elias-alvarez/typescript.nvim
    -- 最小 tsserver 实现, 与 tsserver 不同的是, 可直接使用命令
    -- 必须在 tsserver 启动之后启动
    typescript.setup({
      disable_commands = false,
      debug = false,
    })
    keybindings.typescriptKeys()
  end
end

require("lsp.diagnostic").setup()
