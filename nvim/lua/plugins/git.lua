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
        config = function() require("neogit").setup({
            commit_editor = {
                kind = "floating",
                show_staged_diff = false
            }
        }) end
    },
}
