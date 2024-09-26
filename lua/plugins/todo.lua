return {
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            keywords = {
                FIX = {
                    icon = " ", -- icon used for the sign, and in search results
                    color = "error", -- can be a hex color, or a named color (see below)
                    alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "fix", "fixme", "bug" }, -- a set of other keywords that all map to this FIX keywords
                },
                TODO = { icon = " ", color = "info", alt = { "todo" } },
                HACK = { icon = " ", color = "warning", "hack" },
                WARN = { icon = " ", color = "warning", alt = { "WARNING", "warn", "warning" } },
                PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE", "perf" } },
                NOTE = { icon = " ", color = "hint", alt = { "INFO", "note" } },
                TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED", "test" } },
            },
        },
    }
}
