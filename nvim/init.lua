vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.showmatch = true
opt.matchtime = 1
opt.list = true
opt.listchars = { tab = "> ", extends = "<", trail = "·", nbsp = "␣" }
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.splitright = true
opt.splitbelow = true
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.updatetime = 250
opt.timeoutlen = 400
opt.completeopt = { "menu", "menuone", "noselect" }
opt.foldmethod = "marker"
opt.fileencoding = "utf-8"
opt.fileencodings = { "ucs-bom", "utf-8", "euc-jp", "cp932" }
opt.fileformats = { "unix", "dos", "mac" }
opt.history = 5000

if vim.fn.has("clipboard") == 1 then
  opt.clipboard:append("unnamedplus")
end

local map = vim.keymap.set

map("n", "j", "gj", { silent = true })
map("n", "k", "gk", { silent = true })
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
map("n", "<Esc><Esc>", "<cmd>nohlsearch<CR>", { silent = true, desc = "Clear search highlight" })
map("n", "<leader>w", "<cmd>write<CR>", { desc = "Write file" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit window" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostics" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "ruby", "scss", "yaml", "coffee" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.textwidth = 0
  end,
})

vim.api.nvim_create_user_command("Rename", function(command)
  local old_name = vim.api.nvim_buf_get_name(0)
  vim.cmd.saveas(vim.fn.fnameescape(command.args))
  if old_name ~= "" and old_name ~= vim.api.nvim_buf_get_name(0) then
    vim.fn.delete(old_name)
  end
end, { nargs = 1, complete = "file" })

local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazy_path) then
  local output = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazy_path,
  })
  if vim.v.shell_error ~= 0 then
    error("Failed to install lazy.nvim:\n" .. output)
  end
end
vim.opt.rtp:prepend(lazy_path)

require("lazy").setup("plugins", {
  change_detection = { notify = false },
  checker = { enabled = true, notify = false },
  ui = { border = "rounded" },
})
