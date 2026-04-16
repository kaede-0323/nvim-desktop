-- ~/.config/nvim/lua/config/options.lua

-- Globals
vim.g.VM_case_setting = "smart"
vim.g.VM_default_mapping = 1
vim.g.VM_highlight_matches = ""
vim.g.autoformat = true
vim.g.markdown_recommended_style = 0
vim.g.pioConfig = { lsp = "clangd", clangd_source = "ccls", menu_key = "<leader>p", debug = false }

-- Options
local opt = vim.opt
opt.backup = false
opt.breakindent = true
opt.clipboard = "unnamedplus"
opt.colorcolumn = "+1"
opt.completeopt = { "menu", "menuone", "noselect" }
opt.cursorline = true
opt.expandtab = true
opt.fillchars = { diff = "/", eob = " ", fold = " " }
opt.ignorecase = true
opt.laststatus = 3
opt.list = true
opt.listchars = { eol = " ", extends = "<", nbsp = "%", precedes = ">", tab = ">-", trail = "-" }
opt.mouse = ""
opt.number = true
opt.pumheight = 10
opt.relativenumber = true
opt.scrolloff = 4
opt.shiftwidth = 2
opt.showcmd = true
opt.showmode = false
opt.signcolumn = "yes:1"
opt.smartcase = true
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = 300
opt.undofile = true
opt.updatetime = 200
opt.winblend = 10
opt.writebackup = false

-- Diagnostics
vim.diagnostic.config({ virtual_text = false })
