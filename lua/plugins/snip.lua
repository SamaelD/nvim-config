return {
    {
        "L3MON4D3/LuaSnip",
        config = function()
            require("luasnip.loaders.from_lua").lazy_load {}
            require("luasnip.loaders.from_vscode").lazy_load {
                paths = {
                    require("global").get_plugins_dir() .. "/friendly-snippets"
                }
            }
            require("luasnip.loaders.from_snipmate").lazy_load {}
        end,
        dependencies = { "rafamadriz/friendly-snippets" },
        lazy = false,
    },
}
