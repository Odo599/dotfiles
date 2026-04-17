return {
   {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function() require("lualine").setup({
           sections = {
               lualine_a = {"mode"},
               lualine_b = {"branch", "diff", "diagnostics"},
               lualine_c = {
                   { "filename", path = 1 }
               },
               lualine_x = {"filetype"},
               lualine_y = {"progress"},
               lualine_z = {"location"},
           } 
        }) end,
    },
    {
        "goolord/alpha-nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local startify = require("alpha.themes.theta")
            require("alpha").setup(startify.config)
        end,
    }
}
