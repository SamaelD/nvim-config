return {
    {
        "rcarriga/nvim-notify",
        lazy = false,
        config = function()
            local nvim_notify = require("notify")

            nvim_notify.setup {
                -- Animation style
                stages = "fade_in_slide_out",
                -- Default timeout for notifications
                timeout = 1500,
                background_colour = "#2E3440",
            }

            vim.notify = nvim_notify
        end,
    },
    {
        "folke/noice.nvim",
        config = function()
            require("noice").setup({
                -- add any options here
                routes = {
                    {
                        filter = {
                            event = 'msg_show',
                            any = {
                                { find = '%d+L, %d+B' },
                                { find = '; after #%d+' },
                                { find = '; before #%d+' },
                                { find = '%d fewer lines' },
                                { find = '%d more lines' },
                            },
                        },
                        opts = { skip = true },
                    }
                },
            })
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    },
}
