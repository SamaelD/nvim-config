return {
    {
        "xzbdmw/colorful-menu.nvim",
        config = function()
            require("colorful-menu").setup({})
        end,
    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        'saghen/blink.compat',
        version = '2.*',
        lazy = true,
        opts = {},
    },
    {
        "Saghen/blink.cmp",
        version = "1.*",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "saghen/blink.compat",
            "Exafunction/windsurf.nvim",

        },
        event = { "InsertEnter", "CmdlineEnter" },
        opts = {
            keymap = {
                preset = "enter",
                ["<C-y>"] = { "select_and_accept" },
            },
            appearance = {
                nerd_font_variant = "mono",
            },
            completion = {
                list = {
                    selection = {
                        auto_insert = true,
                        preselect = true,
                    },
                },
                accept = {
                    auto_brackets = {
                        enabled = true,
                    },
                },
                menu = {
                    border = 'rounded',
                    draw = {
                        treesitter = { "lsp" },
                        columns = { { "kind_icon" }, { "label", gap = 1 } },
                        components = {
                            label = {
                                text = function(ctx)
                                    return require("colorful-menu").blink_components_text(ctx)
                                end,
                                highlight = function(ctx)
                                    return require("colorful-menu").blink_components_highlight(ctx)
                                end,
                            },
                        },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                },
                ghost_text = {
                    enabled = false,
                },
            },
            sources = {
                default = { "lazydev", "lsp", "path", "snippets", "buffer", "codeium" },
                providers = {
                    codeium = {
                        name = "codeium",
                        module = "blink.compat.source",
                        score_offset = 100,
                        async = true,
                    },
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                },
            },
            fuzzy = {
                implementation = "prefer_rust_with_warning",
            },
            signature = {
                enabled = true,
            },
        },

        config = function(_, opts)
            local enabled = opts.sources.default
            for _, source in ipairs(opts.sources.compat or {}) do
                opts.sources.providers[source] = vim.tbl_deep_extend(
                    "force",
                    { name = source, module = "blink.compat.source" },
                    opts.sources.providers[source] or {}
                )
                if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
                    table.insert(enabled, source)
                end
            end

            -- add ai_accept to <Tab> key
            if not opts.keymap["<Tab>"] then
                opts.keymap["<Tab>"] = {
                    function(fallback)
                        if vim.snippet.active({ direction = 1 }) then
                            vim.schedule(function()
                                vim.snippet.jump(1)
                            end)
                        elseif require("codeium.virtual_text").get_current_completion_item() then
                            if vim.api.nvim_get_mode().mode == "i" then
                                local undo = vim.api.nvim_replace_termcodes("<c-G>u", true, true, true)
                                vim.api.nvim_feedkeys(undo, "n", false)
                            end
                            vim.api.nvim_input(require("codeium.virtual_text").accept())
                        elseif type(fallback) == "function" then
                            fallback()
                        end
                    end,
                }
            end

            require("blink.cmp").setup(opts)
        end,
    },

    -- {
    --     "hrsh7th/nvim-cmp",
    --     version = false,
    --     event = { "InsertEnter", "CmdlineEnter" },
    --     lazy = true,
    --     dependencies = {
    --         "saadparwaiz1/cmp_luasnip",
    --         'hrsh7th/cmp-nvim-lsp',
    --         'hrsh7th/cmp-buffer',
    --         'hrsh7th/cmp-path',
    --         'hrsh7th/cmp-cmdline',
    --         'hrsh7th/nvim-cmp',
    --         'hrsh7th/cmp-vsnip',
    --         'hrsh7th/vim-vsnip',
    --     },
    --     opts = function()
    --         local cmp = require 'cmp'
    --         local luasnip = require 'luasnip'
    --
    --         vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
    --
    --         return {
    --             snippet = {
    --                 expand = function(args)
    --                     luasnip.lsp_expand(args.body)
    --                 end,
    --             },
    --             completion = { completeopt = 'menu,menuone,noinsert' },
    --             enabled = function()
    --                 local files = {
    --                     "oil"
    --                 }
    --
    --                 local buffer = vim.bo.filetype
    --
    --                 if vim.tbl_contains(files, buffer) then
    --                     return false
    --                 end
    --                 return true
    --             end,
    --             mapping = cmp.mapping.preset.insert {
    --                 ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    --                 ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    --                 ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    --                 ['<C-f>'] = cmp.mapping.scroll_docs(4),
    --                 ['<C-y>'] = cmp.mapping.confirm { select = true },
    --                 ['<CR>'] = cmp.mapping.confirm { select = true },
    --                 ['<Tab>'] = function(fallback)
    --                     if vim.snippet.active({ direction = 1 }) then
    --                         vim.schedule(function()
    --                             vim.snippet.jump(1)
    --                         end)
    --                     elseif require("codeium.virtual_text").get_current_completion_item() then
    --                         if vim.api.nvim_get_mode().mode == "i" then
    --                             local undo = vim.api.nvim_replace_termcodes("<c-G>u", true, true, true)
    --                             vim.api.nvim_feedkeys(undo, "n", false)
    --                         end
    --                         vim.api.nvim_input(require("codeium.virtual_text").accept())
    --                     elseif type(fallback) == "function" then
    --                         fallback()
    --                     end
    --                 end,
    --                 ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    --                 ['<C-Space>'] = cmp.mapping.complete {},
    --                 ['<C-l>'] = cmp.mapping(function()
    --                     if luasnip.expand_or_locally_jumpable() then
    --                         luasnip.expand_or_jump()
    --                     end
    --                 end, { 'i', 's' }),
    --                 ['<C-h>'] = cmp.mapping(function()
    --                     if luasnip.locally_jumpable(-1) then
    --                         luasnip.jump(-1)
    --                     end
    --                 end, { 'i', 's' }),
    --             },
    --             formatting = {
    --                 format = require('lspkind').cmp_format({
    --                     mode = "symbol",
    --                     maxwidth = 50,
    --                     ellipsis_char = '...',
    --                     symbol_map = { Codeium = " ", },
    --                 })
    --             },
    --             sources = {
    --                 { name = 'nvim_lsp' },
    --                 { name = 'luasnip' },
    --                 { name = 'path' },
    --                 { name = 'buffer' },
    --                 { name = 'snacks' },
    --                 {
    --                     name = 'codeium',
    --                     group_index = 1,
    --                     priority = 100
    --                 },
    --                 { name = 'copilot' }
    --             },
    --         }
    --     end,
    -- },
}
