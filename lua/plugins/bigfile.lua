return {
    {
        "lunarvim/bigfile.nvim",
        config = function()
            pcall(function()
                require("bigfile").setup({})
            end)
        end,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        event = { "FileReadPre", "BufReadPre", "User FileOpened" },
    }
}
