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
            })

            vim.cmd.colorscheme "catppuccin"
        end,
    }
}
