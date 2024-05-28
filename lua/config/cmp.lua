local _cmp = {}

local icons_kind = {
    Array = "",
    Boolean = "",
    Class = "",
    Color = "",
    Constant = "",
    Constructor = "",
    Enum = "",
    EnumMember = "",
    Event = "",
    Field = "",
    File = "",
    Folder = "󰉋",
    Function = "",
    Interface = "",
    Key = "",
    Keyword = "",
    Method = "",
    Module = "",
    Namespace = "",
    Null = "󰟢",
    Number = "",
    Object = "",
    Operator = "",
    Package = "",
    Property = "",
    Reference = "",
    Snippet = "",
    String = "",
    Struct = "",
    Text = "",
    TypeParameter = "",
    Unit = "",
    Value = "",
    Variable = "",
}

local source_names = {
    nvim_lsp = "(LSP)",
    emoji = "(Emoji)",
    path = "(Path)",
    calc = "(Calc)",
    cmp_tabnine = "(Tabnine)",
    vsnip = "(Snippet)",
    luasnip = "(Snippet)",
    buffer = "(Buffer)",
    tmux = "(TMUX)",
    copilot = "(Copilot)",
    treesitter = "(TreeSitter)",
}

local duplicates = {
    buffer = 1,
    path = 1,
    nvim_lsp = 0,
    luasnip = 1,
}

function _cmp:setup()
    local status_cmp_ok, cmp_types = pcall(require, "cmp.types.cmp")
    if not status_cmp_ok then
        return
    end
    local ConfirmBehavior = cmp_types.ConfirmBehavior
    local SelectBehavior = cmp_types.SelectBehavior
    local cmp_mapping = require "cmp.config.mapping"

    local cmp = require("cmp")
    cmp.setup {
        completion = {
            keyword_length = 1,
        },
        formatting = {
            fields = { "kind", "abbr", "menu" },
            format = function(entry, vim_item)
                if entry.source.name == "cmp_tabnine" then
                    vim_item.kind = "󰚩"
                    vim_item.kind_hl_group = "CmpItemKindTabnine"
                elseif entry.source.name == "crates" then
                    vim_item.kind = ""
                    vim_item.kind_hl_group = "CmpItemKindCrate"
                elseif entry.source.name == "lab.quick_data" then
                    vim_item.kind = ""
                    vim_item.kind_hl_group = "CmpItemKindConstant"
                elseif entry.source.name == "emoji" then
                    vim_item.kind = ""
                    vim_item.kind_hl_group = "CmpItemKindEmoji"
                elseif entry.source.name == "codeium" then
                    vim_item.kind = ""
                    vim_item.kind_hl_group = "CmpItemKindCodeium"
                else
                    vim_item.kind = icons_kind[vim_item.kind]
                    vim_item.menu = source_names[entry.source.name]
                    vim_item.dup = duplicates[entry.source.name] or 0
                end
                return vim_item
            end
        },
        sources = {
            {
                name = "nvim_lsp",
                entry_filter = function(entry, ctx)
                    local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
                    if kind == "Snippet" and ctx.prev_context.filetype == "java" then
                        return false
                    end
                    return true
                end,
            },
            { name = "path" },
            { name = "luasnip" },
            { name = "cmp_tabnine" },
            { name = "nvim_lua" },
            { name = "buffer" },
            { name = "calc" },
            { name = "emoji" },
            { name = "treesitter" },
            { name = "crates" },
            { name = "tmux" },
            { name = "codeium" },
        },
        mapping = cmp_mapping.preset.insert {
            ["<C-k>"] = cmp_mapping(cmp_mapping.select_prev_item(), { "i", "c" }),
            ["<C-j>"] = cmp_mapping(cmp_mapping.select_next_item(), { "i", "c" }),
            ["<Down>"] = cmp_mapping(cmp_mapping.select_next_item { behavior = SelectBehavior.Select }, { "i" }),
            ["<Up>"] = cmp_mapping(cmp_mapping.select_prev_item { behavior = SelectBehavior.Select }, { "i" }),
            ["<C-d>"] = cmp_mapping.scroll_docs(-4),
            ["<C-f>"] = cmp_mapping.scroll_docs(4),
            ["<C-Space>"] = cmp_mapping.complete(),
            ["<C-e>"] = cmp_mapping.abort(),
            ["<Tab>"] = cmp_mapping.select_next_item(),
            ["<S-Tab>"] = cmp_mapping.select_prev_item(),
            ["<CR>"] = cmp_mapping(function(fallback)
                if cmp.visible() then
                    local confirm_opts = {
                        behavior = ConfirmBehavior.Replace,
                        select = false,
                    }
                    local is_insert_mode = function()
                        return vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
                    end
                    if is_insert_mode() then -- prevent overwriting brackets
                        confirm_opts.behavior = ConfirmBehavior.Insert
                    end
                    if cmp.confirm(confirm_opts) then
                        return
                    end
                end
                fallback()
            end),
        },
        cmdline = {
            enable = false,
            options = {
                {
                    type = ":",
                    sources = {
                        { name = "path" },
                        { name = "cmdline" },
                    },
                },
                {
                    type = { "/", "?" },
                    sources = {
                        { name = "buffer" },
                    },
                },
            },
        },
    }
end

return _cmp
