vim.g.mapleader = " "
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.cmdheight = 0
vim.opt.relativenumber = true

require("config.lazy")
require("config.binds")
vim.cmd[[colorscheme tokyonight-night]]

