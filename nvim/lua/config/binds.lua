local telescope_builtin = require("telescope.builtin")
local neogit = require("neogit")
local fterm = require("FTerm")

vim.keymap.set("n","<leader>ff", telescope_builtin.find_files)
vim.keymap.set("n","<leader>fh", "<cmd>Telescope find_files no_ignore=true<cr>")
vim.keymap.set("n","<leader>fg", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n","<leader>bb", telescope_builtin.buffers)

vim.keymap.set("n","<leader>jj", "<cmd>HopWord<cr>")

vim.keymap.set(
    "n",
    "<leader>gg", 
    function() neogit.open({kind = "floating"}) end
)

vim.keymap.set("n", "<A-t>",fterm.toggle)
vim.keymap.set("t", "<A-t>",fterm.toggle)
