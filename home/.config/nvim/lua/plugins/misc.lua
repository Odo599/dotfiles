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
    },
    {
        "xiyaowong/transparent.nvim",
        lazy = false
    },
    {
        "wurli/visimatch.nvim",
        opts = {
            chars_lower_limit = 3,
        }
    }
}
