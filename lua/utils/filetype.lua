local mappings = {}
mappings.filename = {
  bashrc = "bash",
  yabairc = "bash",
  skhdrc = "bash",
  spacebarrc = "bash",
  [".env"] = "bash",
  [".bashrc"] = "bash",
  [".zprofile"] = "bash",
  ["vifmrc"] = "vim",
  [".gitignore"] = "bash",
}
mappings.extension = {
  sh = "bash",
  env = "bash",
  profile = "bash",
  json = "jsonc",
}

-- 重新覆盖文件类型 setlocal filetype

return function()
  -- 获取当前文件的文件名/后缀名
  -- 如果有值,证明需要重新设置 filetype
  local filename, extension = vim.fn.expand("%:t"), vim.fn.expand("%:e")
  local filetype = mappings.filename[filename] or mappings.extension[extension]
  if filetype then
    vim.cmd("setlocal filetype=" .. filetype)
  end
end
