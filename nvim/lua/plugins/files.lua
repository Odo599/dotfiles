return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            {
                "<leader>ff",
                "<cmd>Telescope find_files<cr>",
                desc = "Find files",
            },
            {
                "<leader>bb",
                "<cmd>Telescope buffers<cr>",
                desc = "View buffers"
            }
        },
    },
}
