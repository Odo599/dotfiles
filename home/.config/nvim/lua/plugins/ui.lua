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
            local theta = require("alpha.themes.theta")
            local dashboard = require("alpha.themes.dashboard")
            theta.buttons.val = {
                { type = "text",    val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
                { type = "padding", val = 1 },
                dashboard.button("e", "  New file", "<cmd>ene<CR>"),
                dashboard.button("_ f f", "󰈞  Find file"),
                dashboard.button("_ f g", "󰊄  Live grep"),
                dashboard.button("u", "  Update plugins", "<cmd>Lazy sync<CR>"),
                dashboard.button("q", "󰅚  Quit", "<cmd>qa<CR>"),
            },
            require("alpha").setup(theta.config)
        end,
    }
}
