local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n","<leader>ff", telescope_builtin.find_files)
vim.keymap.set("n","<leader>bb", telescope_builtin.buffers)

vim.keymap.set("n","<leader>jj", "<cmd>HopWord<cr>")
vim.keymap.set("n","<leader>gg", "<cmd>Neogit<cr>")
