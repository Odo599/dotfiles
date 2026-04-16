local telescope_builtin = require("telescope.builtin")
local neogit = require("neogit")

vim.keymap.set("n","<leader>ff", telescope_builtin.find_files)
vim.keymap.set("n","<leader>bb", telescope_builtin.buffers)

vim.keymap.set("n","<leader>jj", "<cmd>HopWord<cr>")

vim.keymap.set(
    "n",
    "<leader>gg", 
    function() neogit.open({kind = "floating"}) end
)
