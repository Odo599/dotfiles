return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function() require("telescope").setup({
            pickers = {
                find_files = {
                    hidden = true,
                    file_ignore_patterns = {
                        ".git/",
                    }
                },
                live_grep = {
                    hidden = true
                }
            }
        }) end
    },
}
