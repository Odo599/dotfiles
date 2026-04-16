return {
    {
        "esmuellert/codediff.nvim",
        cmd = "CodeDiff",
        opts = {
            diff = {
                layout = "inline"
            }
        }
    },
    {
        "NeogitOrg/neogit",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "esmuellert/codediff.nvim",
            "m00qek/baleia.nvim",
            "nvim-telescope/telescope.nvim"
        },
        cmd = "Neogit",
        keys = {
            { "<leader>gg", "<cmd>Neogit<cr>", desc="Show Neogit UI" }
        }
    },
}
