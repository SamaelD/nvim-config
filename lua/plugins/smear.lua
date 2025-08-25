return {
    "sphamba/smear-cursor.nvim",
    config = function()
        require("smear_cursor").setup {
            stiffness = 0.5,
            trailing_stiffness = 0.5,
            matrix_pixel_threshold = 0.5,
            legacy_computing_symbols_support = true,
        }
    end,
}
