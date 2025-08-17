return {
    {
        "Exafunction/windsurf.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
        },
        config = function()
            require("codeium").setup({
                enable_cmp_source = true,
                enable_chat = true,
                virtual_text = {
                    enabled = true,
                    key_bindings = {
                        accept = false, -- handled by nvim-cmp / blink.cmp
                        next = "<M-]>",
                        prev = "<M-[>",
                    },
                }
            })
        end,
    },

    {
        "tzachar/cmp-tabnine",
        build = "./install.sh",
        opts = {
            max_lines = 1000,
            max_num_results = 3,
            sort = true,
        },
        config = function(_, opts)
            require("cmp_tabnine.config"):setup(opts)
        end,
    },
}
