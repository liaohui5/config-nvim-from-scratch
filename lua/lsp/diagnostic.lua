-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 内置的 API 更改代码诊断 UI                                                   │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
return {
  setup = function()
    local icons = {
      Error = "",
      Warn = "",
      Hint = "󰌵",
      Info = "",
    }

    -- 提示信息图标设置
    local signs = {}
    for key, icon in pairs(icons) do
      local sign_name = string.format("DiagnosticSign%s", key)
      local item = {
        name = sign_name,
        text = icon,
      }
      table.insert(signs, item)
      vim.fn.sign_define(sign_name, item)
    end

    -- 配置代码诊断选项
    -- 文档: :h vim.diagnostic.config()
    vim.diagnostic.config({
      virtual_text = false, -- 是否显示错误信息提示文字
      update_in_insert = false,
      underline = true,
      severity_sort = true,
      signs = { active = signs }, -- 诊断信息的对应图标
      float = {
        width = 100, -- 默认宽度
        max_width = 150, -- 最大宽度
        style = "minimal",
        border = "rounded",
        source = "always",
        focusable = false, -- 不能获取光标焦点
        prefix = function(d, i, t)
          local s = vim.diagnostic.severity
          local icon = ({
                [s.ERROR] = icons.Error,
                [s.WARN] = icons.Warn,
                [s.INFO] = icons.INFO,
                [s.HINT] = icons.Hint,
              })[d.severity]
          return string.format(" %s ", icon)
        end,
      },
    })
  end,
}
