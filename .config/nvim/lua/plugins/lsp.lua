return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "pyright", "html", "ts_ls", "nil_ls" },
            })
        end,
    },

    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.lsp.config("pyright", {
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = "basic",
                        },
                    },
                },
            })
            vim.lsp.config("html", {})
            vim.lsp.config("nil_ls", {})
            vim.lsp.config("ts_ls", {
                settings = {
                    typescript = {
                        inlayHints = {
                            includeInlayParameterNameHints = "all",
                            includeInlayVariableTypeHints = true,
                        },
                    },
                    javascript = {
                        inlayHints = {
                            includeInlayParameterNameHints = "all",
                            includeInlayVariableTypeHints = true,
                        },
                    },
                },
            })

            vim.lsp.enable("pyright")
            vim.lsp.enable("html")
            vim.lsp.enable("ts_ls")
            vim.lsp.enable("nil_ls")

            vim.keymap.set("n", "gd", vim.lsp.buf.definition)
            vim.keymap.set("n", "K", vim.lsp.buf.hover)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = {
                    { name = "nvim_lsp" },
                },
                window = {
                    completion = {
                        winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel",
                        side_padding = 0,
                        col_offset = -3,
                    },
                    documentation = {
                        border = "rounded",
                    },
                }
            })

            require("lspconfig")
        end,
    },
    {
        "nvim-flutter/flutter-tools.nvim",
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "stevearc/dressing.nvim"
        },
        config = function() require("flutter-tools").setup({
            lsp = {
                settings = {
                    completeFunctionCalls = false,
                    showTodos = false,
                }
            }
        }) end, 
    },
    {
        "folke/trouble.nvim",
        opts = {},
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            }
        },
    },
    {
        "m4xshen/autoclose.nvim",
        config = function() require("autoclose").setup() end
    },
}
