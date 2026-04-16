-- ~/.config/nvim/init.lua

-- オプションとキーマップの読み込み
require("config.options")
require("config.keymaps")

-- lazy.nvimのブートストラップ
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- プラグインと自動コマンドの読み込み
require("lazy").setup("plugins")
require("config.autocmds")
