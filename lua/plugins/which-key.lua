return {
    {
        "folke/which-key.nvim",
        config = function()
            local which_key = require "which-key"
            which_key.setup {}
        end,
        cmd = "WhichKey",
        event = "VeryLazy",
    }
}
