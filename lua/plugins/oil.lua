return {
    {
        'stevearc/oil.nvim',
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup({
                default_file_explorer = true,
                delete_to_trash = true,
                view_options = {
                    show_hidden = true,
                    is_always_hidden = function(name, bufnr)
                        return name == ".git"
                    end,
                },
                win_options = {
                    wrap = false,
                }
            })

            vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
        end,
    }
}
