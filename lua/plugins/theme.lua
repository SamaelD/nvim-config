return {
    -- {
    --     "loctvl842/monokai-pro.nvim",
    --     config = function()
    --         vim.cmd('colorscheme monokai-pro')
    --     end
    -- },
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
                default_integrations = true,
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    notify = true,

                    dashboard = true,
                    flash = true,
                    fzf = true,
                    which_key = true,
                }
            })

            vim.cmd.colorscheme "catppuccin"
        end,
    }
}
