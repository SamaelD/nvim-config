-- transparent mode
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        local hl_groups = {
            "Normal",
            "SignColumn",
            "NormalNC",
            "TelescopeBorder",
            "NeoTreeNormal",
            "NeoTreeNormalNC",
            "EndOfBuffer",
            "MsgArea",
        }
        for _, name in ipairs(hl_groups) do
            vim.cmd(string.format("highlight %s ctermbg=none guibg=none", name))
        end
    end,
})
vim.opt.fillchars = "eob: "

-- highlight yank
vim.api.nvim_create_augroup("highlight_yank", {})
vim.api.nvim_create_autocmd("TextYankPost", {
    group = "highlight_yank",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
    end,
})
