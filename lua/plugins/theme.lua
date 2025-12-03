return {
    {
        "rebelot/kanagawa.nvim",
        config = function()
            require("kanagawa").setup({
                transparent = true,
                overrides = function(colors)
                    local theme = colors.theme
                    return {
                        NormalFloat = { bg = "none" },
                        FloatBorder = { bg = "none" },
                        FloatTitle = { bg = "none" },
                        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
                        PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                        PmenuSbar = { bg = theme.ui.bg_m1 },
                        PmenuThumb = { bg = theme.ui.bg_p2 },
                    }
                end,
            })
            require("kanagawa").load("dragon")
            vim.api.nvim_create_autocmd("ColorScheme", {
                pattern = "kanagawa",
                callback = function()
                    if vim.o.background == "light" then
                        vim.fn.system("kitty +kitten themes Kanagawa_light")
                    elseif vim.o.background == "dark" then
                        vim.fn.system("kitty +kitten themes Kanagawa_dragon")
                    else
                        vim.fn.system("kitty +kitten themes Kanagawa")
                    end
                end,
            })
        end,
    },
    -- {
    --     "loctvl842/monokai-pro.nvim",
    --     config = function()
    --         require("monokai-pro").setup({
    --             transparent_background = true,
    --             filter = "spectrum",
    --         })
    --     end,
    -- },
    -- {
    --     "catppuccin/nvim",
    --     name = "catppuccin",
    --     priority = 1000,
    --     config = function()
    --         require("catppuccin").setup({
    --             flavour = "mocha",
    --             transparent_background = true,
    --             styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
    --                 comments = { "italic" }, -- Change the style of comments
    --             },
    --             float = {
    --                 transparent = true,
    --             },
    --             default_integrations = true,
    --             auto_integrations = true,
    --             integrations = {
    --                 cmp = true,
    --                 blink_cmp = true,
    --                 gitsigns = true,
    --                 neotree = true,
    --                 treesitter = true,
    --                 treesitter_context = true,
    --                 notify = true,
    --                 noice = true,
    --                 bufferline = true,
    --                 telescope = {
    --                     enabled = true,
    --                 },
    --                 lsp_trouble = true,
    --                 bufferline = true,
    --
    --                 dashboard = true,
    --                 snacks = {
    --                     enabled = true,
    --                     indent_scope_color = "lavender",
    --                 },
    --                 flash = true,
    --                 fzf = true,
    --                 which_key = true,
    --                 markdown = true,
    --                 native_lsp = {
    --                     enabled = true,
    --                     virtual_text = {
    --                         errors = { "italic" },
    --                         hints = { "italic" },
    --                         warnings = { "italic" },
    --                         information = { "italic" },
    --                         ok = { "italic" },
    --                     },
    --                     underlines = {
    --                         errors = { "underline" },
    --                         hints = { "underline" },
    --                         warnings = { "underline" },
    --                         information = { "underline" },
    --                         ok = { "underline" },
    --                     },
    --                     inlay_hints = {
    --                         background = true,
    --                     },
    --                 },
    --             },
    --         })
    --
    --         vim.cmd.colorscheme("catppuccin")
    --     end,
    -- },
}
