return {
    {
        "hrsh7th/nvim-cmp",
        version = false,
        event = { "InsertEnter", "CmdlineEnter" },
        lazy = true,
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip',
        },
        opts = function()
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'

            vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

            return {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = { completeopt = 'menu,menuone,noinsert' },
                enabled = function()
                    local files = {
                        "oil"
                    }

                    local buffer = vim.bo.filetype

                    if vim.tbl_contains(files, buffer) then
                        return false
                    end
                    return true
                end,
                mapping = cmp.mapping.preset.insert {
                    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-y>'] = cmp.mapping.confirm { select = true },
                    ['<CR>'] = cmp.mapping.confirm { select = true },
                    ['<Tab>'] = function(fallback)
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
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                    ['<C-Space>'] = cmp.mapping.complete {},
                    ['<C-l>'] = cmp.mapping(function()
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        end
                    end, { 'i', 's' }),
                    ['<C-h>'] = cmp.mapping(function()
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        end
                    end, { 'i', 's' }),
                },
                formatting = {
                    format = require('lspkind').cmp_format({
                        mode = "symbol",
                        maxwidth = 50,
                        ellipsis_char = '...',
                        symbol_map = { Codeium = " ", },
                    })
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'path' },
                    { name = 'codeium' },
                    { name = 'buffer' },
                    { name = 'snacks' },
                    {
                        name = 'codeium',
                        group_index = 1,
                        priority = 100
                    },
                },
            }
        end,
    },
}
