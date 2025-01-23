return {
    -- {
    --     "loctvl842/monokai-pro.nvim",
    --     config = function()
    --         vim.cmd('colorscheme monokai-pro')
    --         -- transparent mode
    --         vim.api.nvim_create_autocmd("ColorScheme", {
    --             pattern = "*",
    --             callback = function()
    --                 local hl_groups = {
    --                     "Normal",
    --                     "SignColumn",
    --                     "NormalNC",
    --                     "TelescopeBorder",
    --                     "NeoTreeNormal",
    --                     "NeoTreeNormalNC",
    --                     "EndOfBuffer",
    --                     "MsgArea",
    --                 }
    --                 for _, name in ipairs(hl_groups) do
    --                     vim.cmd(string.format("highlight %s ctermbg=none guibg=none", name))
    --                 end
    --             end,
    --         })
    --     end
    -- },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "macchiato",
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
