return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", config = true },
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            { "j-hui/fidget.nvim", opts = {} },
            -- { "folke/neodev.nvim",       opts = {} },
            "hrsh7th/nvim-cmp",
            "Saghen/blink.cmp",
        },
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                    end

                    map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                    map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                    map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
                    map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
                    map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
                    map(
                        "<leader>ws",
                        require("telescope.builtin").lsp_dynamic_workspace_symbols,
                        "[W]orkspace [S]ymbols"
                    )
                    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
                    map("<leader>hd", vim.lsp.buf.hover, "[H]over [D]ocumentation")
                    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client then
                        if client.server_capabilities.documentHighlightProvider then
                            local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
                            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                                buffer = event.buf,
                                group = highlight_augroup,
                                callback = vim.lsp.buf.document_highlight,
                            })

                            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                                buffer = event.buf,
                                group = highlight_augroup,
                                callback = vim.lsp.buf.clear_references,
                            })

                            vim.api.nvim_create_autocmd("LspDetach", {
                                group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
                                callback = function(event2)
                                    vim.lsp.buf.clear_references()
                                    vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
                                end,
                            })
                        end

                        if client.server_capabilities.inlayHintProvider then
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                        end

                        if client.name == "clangd" then
                            map("<leader>hs", "<cmd>LspClangdSwitchSourceHeader<cr>", "[H]eader/[S]ource switch")
                        end
                    end
                end,
            })

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities =
                vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities(capabilities))

            local servers = {
                clangd = {
                    filetypes = { "h", "hpp", "inc", "cpp", "c", "cc", "cppm" },
                    cmd = {
                        "clangd",
                        "--clang-tidy",
                        "--background-index",
                        "--completion-style=detailed",
                        "--header-insertion=iwyu",
                        "--enable-config",
                    },
                    single_file_support = true,
                    root_dir = function()
                        return vim.fn.getcwd()
                    end,
                },
                pyright = {
                    settings = {
                        pyright = {
                            disableOrganizeImports = true,
                        },
                        python = {
                            analysis = {
                                typeCheckingMode = "off",
                                diagnosticMode = "openFilesOnly",
                                autoSearchPaths = true,
                                useLibraryCodeForTypes = true,
                            },
                        },
                    },
                    handlers = {
                        -- Disable diagnostics in favor of ruff
                        ["textDocument/publishDiagnostics"] = function() end,
                    },
                },
                rust_analyzer = {},
                cmake = {},
                kotlin_language_server = {},

                lua_ls = {
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = "Replace",
                            },
                            diagnostics = {
                                globals = { "vim" },
                                disable = { "missing-fields" },
                            },
                        },
                    },
                },
                qmlls = {},
                ruff = {
                    on_attach = function(client, bufnr)
                        -- Disable hover in favor of Pyright
                        client.server_capabilities.hoverProvider = false
                    end,
                },
            }

            require("mason").setup()

            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                "stylua", -- Used to format Lua code
            })
            require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

            require("mason-lspconfig").setup({
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                        require("lspconfig")[server_name].setup(server)
                    end,
                },
            })
        end,
    },
    { "nvimtools/none-ls.nvim", lazy = true },
    { "jay-babu/mason-null-ls.nvim" },
    { "onsails/lspkind.nvim" },
}
