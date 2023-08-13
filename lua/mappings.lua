--  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .-----------------. .----------------.  .----------------.
-- | .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. |
-- | | ____    ____ | || |      __      | || |   ______     | || |   ______     | || |     _____    | || | ____  _____  | || |    ______    | || |    _______   | |
-- | ||_   \  /   _|| || |     /  \     | || |  |_   __ \   | || |  |_   __ \   | || |    |_   _|   | || ||_   \|_   _| | || |  .' ___  |   | || |   /  ___  |  | |
-- | |  |   \/   |  | || |    / /\ \    | || |    | |__) |  | || |    | |__) |  | || |      | |     | || |  |   \ | |   | || | / .'   \_|   | || |  |  (__ \_|  | |
-- | |  | |\  /| |  | || |   / ____ \   | || |    |  ___/   | || |    |  ___/   | || |      | |     | || |  | |\ \| |   | || | | |    ____  | || |   '.___`-.   | |
-- | | _| |_\/_| |_ | || | _/ /    \ \_ | || |   _| |_      | || |   _| |_      | || |     _| |_    | || | _| |_\   |_  | || | \ `.___]  _| | || |  |`\____) |  | |
-- | ||_____||_____|| || ||____|  |____|| || |  |_____|     | || |  |_____|     | || |    |_____|   | || ||_____|\____| | || |  `._____.'   | || |  |_______.'  | |
-- | |              | || |              | || |              | || |              | || |              | || |              | || |              | || |              | |
-- | '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' |
--  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'
local helpers, wk = require("utils.helpers"), require("which-key")

---leader key bind
vim.g.mapleader = " "
vim.g.localleader = " "

--- normal mode keymappings
wk.register({
  -- single key remapping
  ["<leader>"] = { name = " which-key menus" },
  ["x"] = { [["_x]], "delete" },
  ["-"] = { "<cmd>nohl<cr>", "cancel Highlight" },
  -- fold
  ["z"] = { name = "+Fold" },
  -- window manage
  ["<c-w>"] = {
    o = { "<cmd>only<cr>", "close other windows" },
    H = { "<cmd>wincmd H<cr>", "move window ←" },
    J = { "<cmd>wincmd J<cr>", "move window ↓" },
    K = { "<cmd>wincmd K<cr>", "move window ↑" },
    L = { "<cmd>wincmd L<cr>", "move window →" },
  },
  --quit
  ["<c-q>"] = { "<cmd>quitall!<cr>", "quit editor" },
  -- scroll
  ["<c-u>"] = { "10kzz", "scroll up" },
  ["<c-d>"] = { "10jzz", "scroll down" },
  ["<c-b>"] = { "<c-b>zz", "backword" },
  ["<c-f>"] = { "<c-f>zz", "forward" },
  ["<leader>a"] = {
    name = "+Align/AutoImport",
  },
  ["<leader>b"] = {
    name = "+Buffer",
    a = { "<cmd>buffers<cr>", "all buffers" },
    Y = { [[<cmd>%y "<cr>]], "Copy buffer content" },
    P = {
      function()
        vim.cmd("%delete _")
        vim.cmd("put+")
      end,
      "paste to replace buffer content",
    },
  },
  ["<leader>c"] = {
    name = "+Comment/CodeAction",
  },
  -- ["<leader>d"] = {
  --   name = "+Debug",
  -- },
  -- ["<leader>e"] = {
  --   name = "+Errors",
  -- },
  ["<leader>f"] = {
    name = "+File/Format",
    s = { "<cmd>silent confirm write<cr>", "save current buffer" },
  },
  -- ["<leader>g"] = {
  --   name = "+Git",
  -- },
  -- ["<leader>h"] = {
  --   name = "+Help",
  -- },
  ["<leader>i"] = {
    name = "+Insert",
    -- l = { "<ESC>oconsole.log();<ESC>hi", "insert console.log" },
    [";"] = { "<ESC><S-a>;<ESC>", "insert ; end of line" },
    [","] = { "<ESC><S-a>,<ESC>", "insert , end of line" },
    i = { "ihttps://api.lorem.space/image/movie?w=150&h=150<Esc>", "Insert Image URL" },
    e = { "O/* eslint-disable */<ESC>j", "insert eslint-disable comment" },
    p = { "O/* prettier-ignore */<ESC>j", "insert prettier-ignore comment" },
    s = { "O-- stylua: ignore<ESC>j", "insert stylua ignore comment" },
    t = { "O/* @ts-ignore */<ESC>j", "insert @ts-ignore comment" },
  },
  ["<leader>j"] = {
    name = "+Jump/Join/Split",
  },
  ["<leader>l"] = {
    name = "+List",
  },
  -- ["<leader>m"] = {
  --   name = "+Markdown",
  -- },
  ["<leader>o"] = {
    name = "+Open",
    v = {
      function()
        helpers.open_file_with([[Visual\ Studio\ Code.app]])
      end,
      "open file in VSCode",
    },
    o = {
      helpers.open_finder,
      "open file with system explorer",
    },
    c = {
      "<cmd>edit $MYVIMRC<cr>",
      "open settings file",
    },
  },
  -- ["<leader>p"] = {
  --   name = "+Project",
  -- },
  ["<leader>q"] = {
    name = "+Quit",
    q = { "<cmd>quitall!<cr>", "quit editor" },
  },
  ["<leader>r"] = {
    name = "+Replace/Refactor",
  },
  ["<leader>s"] = {
    name = "+Search/Symbol",
  },
  ["<leader>t"] = {
    name = "+Toggles",
    l = {
      function()
        if vim.opt.list:get() then
          vim.opt.list = false
        else
          vim.opt.list = true
        end
      end,
      "toggle listchars visible",
    },
  },
  ["<leader>y"] = {
    name = "+Yank/Copy",
    n = { "<cmd>let @+ = expand('%:t')<cr>", "Copy buffer file name" },
    d = { "<cmd>let @+ = expand('%:p:h')<cr>", "Copy absolute dirname" },
    D = { "<cmd>let @+ = expand('#:p:h')<cr>", "Copy realfile dirname" },
    p = { "<cmd>let @+ = expand('%:p')<cr>", "Copy buffer file absolute path" },
    P = { "<cmd>let @+ = expand('%')<cr>", "Copy buffer file relative path" },
  },
  ["<leader>P"] = {
    name = "+Plugin",
    p = {
      "<cmd>Lazy<cr>",
      "Lazy plugins manager",
    },
    l = {
      "<cmd>LspInfo<cr>",
      "LSP server infos",
    },
    n = {
      "<cmd>NullLsInfo<cr>",
      "null-ls infos",
    },
  },
}, {
  mode = "n",
  noremap = true,
  silent = true,
})

--- visual mode keymappings
wk.register({
  -- single key remapping
  ["p"] = { [["_c<c-r><c-o>+<Esc>]], "just paste" },
  ["$"] = { "$h", "$" },
  ["x"] = { [["_x]], "delete" },
  ["<"] = { "<gv", "outdent" },
  [">"] = { ">gv", "indent" },
  ["H"] = { [[^]], "start of line" },
  ["L"] = { [[$h]], "end of line" },
  -- resize window
  ["<c-Right>"] = { "<cmd>vertical resize-1<cr>", "vertical resize-1" },
  ["<c-Left>"] = { "<cmd>vertical resize+1<cr>", "vertical resize+1" },
  ["<c-Down>"] = { "<cmd>resize-1<cr>", "resize+1" },
  ["<c-Up>"] = { "<cmd>resize+1<cr>", "resize-1" },
  -- move line
  -- ["<leader>il"] = { [["ayoconsole.log("<c-R>a:", <c-R>a);<Esc>]], "insert console.log" },
  ["s"] = { name = "+Selection" },
  ["<leader>c"] = {
    name = "+Comment",
  },
  ["<leader>j"] = {
    name = "+Jump/join/split",
  },
  ["<leader>r"] = {
    name = "+Replace/Refactor",
  },
  ["<leader>s"] = {
    name = "+Search/Symbol",
  },
}, {
  mode = "v",
  noremap = true,
  silent = true,
})

---command line mode mappings
---@param keys string keys
---@param commands function|string commands
local function cmap(keys, commands)
  vim.api.nvim_set_keymap("c", keys, commands, {
    noremap = true,
  })
end
cmap("<c-j>", "<c-n>")
cmap("<c-k>", "<c-p>")
cmap("<c-h>", "<Left>")
cmap("<c-l>", "<Right>")

---insert mode mappings
---@param keys string keys
---@param commands function|string commands
local function inoremap(keys, commands)
  vim.api.nvim_set_keymap("i", keys, commands, { silent = true, noremap = true })
end

inoremap("<c-a>", "<ESC>^i")
inoremap("<c-e>", "<ESC>$a")
inoremap("<c-s>", "<Left>")
inoremap("<c-d>", "<Right>")
inoremap("<c-j>", "<Down>")
inoremap("<c-k>", "<Up>")
