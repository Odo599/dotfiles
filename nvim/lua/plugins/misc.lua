return {
    {
        "smoka7/hop.nvim",
        version = "*",
        opts = {
            keys = "etovxqpdygfblzhckisuran"
        }
    },
    {
        "numToStr/Comment.nvim",
    },
    {
        "kylechui/nvim-surround",
        event = "VeryLazy"
    },
    {
        "numToStr/FTerm.nvim",
        config = function() require("FTerm").setup({
            border = "rounded"
        }) end,
    }
 
}
