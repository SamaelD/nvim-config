return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                transparent_background = true,
                styles = {                   -- Handles the styles of general hi groups (see `:h highlight-args`):
                    comments = { "italic" }, -- Change the style of comments
                },
                float = {
                    transparent = true,
                },
                default_integrations = true,
                auto_integrations = true,
                integrations = {
                    cmp = true,
                    blink_cmp = true,
                    gitsigns = true,
                    neotree = true,
                    treesitter = true,
                    treesitter_context = true,
                    notify = true,
                    noice = true,
                    telescope = {
                        enabled = true
                    },
                    lsp_trouble = true,

                    dashboard = true,
                    snacks = {
                        enabled = true,
                        indent_scope_color = "lavender"
                    },
                    flash = true,
                    fzf = true,
                    which_key = true,
                    markdown = true,
                    native_lsp = {
                        enabled = true,
                        virtual_text = {
                            errors = { "italic" },
                            hints = { "italic" },
                            warnings = { "italic" },
                            information = { "italic" },
                            ok = { "italic" },
                        },
                        underlines = {
                            errors = { "underline" },
                            hints = { "underline" },
                            warnings = { "underline" },
                            information = { "underline" },
                            ok = { "underline" },
                        },
                        inlay_hints = {
                            background = true,
                        },
                    },
                }
            })

            vim.cmd.colorscheme "catppuccin"
        end,
    }
}
