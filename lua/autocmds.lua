local autocmds = {}

function autocmds:enable_transparent_mode()
    vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
            local hl_groups = {
                "Normal",
                "SignColumn",
                "NormalNC",
                "TelescopeBorder",
                "NvimTreeNormal",
                "NvimTreeNormalNC",
                "EndOfBuffer",
                "MsgArea",
            }
            for _, name in ipairs(hl_groups) do
                vim.cmd(string.format("highlight %s ctermbg=none guibg=none", name))
            end
        end,
    })
    vim.opt.fillchars = "eob: "
end

function autocmds:enable_format_on_save()
    local pattern = { "*.lua", "*.h", "*.hpp", "*.cpp", "*.cc", "*.c", "*.py", "*.rs" }
    vim.api.nvim_create_augroup("lsp_format_on_save", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = "lsp_format_on_save",
        pattern = pattern,
        callback = function()
            vim.lsp.buf.format({ timeout_ms = 1000 })
        end,
    })
end

function autocmds:setup()
    vim.api.nvim_create_augroup("highlight_yank", {})
    vim.api.nvim_create_autocmd("TextYankPost", {
        group = "highlight_yank",
        callback = function()
            vim.highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
        end
    })
end

return autocmds
