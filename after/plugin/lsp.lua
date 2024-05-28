local lspconfig = require('lspconfig')
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local caps = cmp_nvim_lsp.default_capabilities()

-- Python
lspconfig.pyright.setup {
    capabilities = caps,
}

-- Lua
lspconfig.lua_ls.setup {
    capabilities = caps,
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}

-- C++
lspconfig.clangd.setup {
    capabilities = caps,
    cmd = { "clangd", "--background-index" },
    root_dir = lspconfig.util.root_pattern(
        ".clangd",
        ".clang-tidy",
        ".clang-format",
        "compile_commands.json",
        "compile_flags.txt",
        "configure.ac",
        ".git"
    ),
}

-- CMake
lspconfig.cmake.setup {
    capabilities = caps,
}

-- Rust
lspconfig.rust_analyzer.setup {
    capabilities = caps,
}

vim.keymap.set("n", "<leader>M", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>ld", vim.diagnostic.setqflist)

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, { buffer = ev.buf })
        vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, { buffer = ev.buf })
        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = ev.buf })
        vim.keymap.set("n", "<leader>C", vim.lsp.buf.code_action, { buffer = ev.buf })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf })
        vim.keymap.set("n", "<leader>K", vim.lsp.buf.signature_help, { buffer = ev.buf })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf })
        vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, { buffer = ev.buf })
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.declaration, { buffer = ev.buf })
    end,
})
