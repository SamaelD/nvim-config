local treesitter = {}

function treesitter:setup()
    require('nvim-treesitter.install').prefer_git = true
    require("nvim-treesitter.configs").setup {
        ensure_installed = {
            "python",
            "lua",
            "c",
            "cpp",
            "vim",
            "json",
            "toml",
            "yaml",
            "rust",
            "bitbake",
            "cmake",
            "bash",
            "kotlin",
        },
        sync_install = false,
        ignore_install = {},
        modules = {},
        auto_install = false,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = false,
                node_decremental = "<bs>",
            },
        },
        textobjects = {
            move = {
                enable = true,
                goto_next_start = { ["]f"] = "@function.outer", ["]o"] = "@class.outer" },
                goto_next_end = { ["]F"] = "@function.outer", ["]O"] = "@class.outer" },
                goto_previous_start = { ["[f"] = "@function.outer", ["[o"] = "@class.outer" },
                goto_previous_end = { ["[F"] = "@function.outer", ["[O"] = "@class.outer" },
            },
            select = {
                enable = true,
                lookahead = true,
                include_surrounding_whitespace = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ao"] = "@class.outer",
                    ["io"] = "@class.inner",
                },
            },
            swap = {
                enable = true,
                swap_next = { ["<leader>a"] = "@parameter.inner" },
                swap_previous = { ["<leader>A"] = "@parameter.inner" },
            },
        },
        ident = { enable = true },
        rainbow = {
            enable = true,
            extended_mode = true,
            max_file_lines = nil,
        },
    }
    require 'treesitter-context'.setup {}
end

return treesitter
