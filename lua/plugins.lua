local plugins = {
    { "folke/lazy.nvim",       tag = "stable" },

    require("plugins.notify"),
    require("plugins.theme"),
    require("plugins.statusline"),

    -- NeoTree
    {
        "nvim-neo-tree/neo-tree.nvim",
        version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        cmd = "Neotree",
        keys = {
            { "\\", ":Neotree reveal<CR>", { desc = "NeoTree reveal" } },
        },
        opts = {
            filesystem = {
                filtered_items = {
                    visible = true,
                    show_hidden_count = true,
                    hide_dotfiles = false,
                    hide_gitignored = true,
                    hide_by_name = {
                        ".git",
                    },
                },
                follow_current_file = {
                    enabled = true,
                },
                window = {
                    mappings = {
                        ["\\"] = "close_window",
                    },
                },
            },
        },
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("config.treesitter").setup({})
        end,
        cmd = {
            "TSInstall",
            "TSUninstall",
            "TSUpdate",
            "TSUpdateSync",
            "TSInstallInfo",
            "TSInstallSync",
            "TSInstallFromGrammar",
        },
        event = "User FileOpened",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
            "nvim-treesitter/nvim-treesitter-textobjects",
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
    },

    { "nvim-lua/plenary.nvim", cmd = { "PlenaryBustedFile", "PlenaryBustedDirectory" }, lazy = true },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
        },
        event = "VimEnter",
    },

    -- Git
    require("plugins.git"),

    -- LSP
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", config = true },
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            { "j-hui/fidget.nvim",       opts = {} },
            { "folke/neodev.nvim",       opts = {} },
        },
        config = function()
            require("config.lsp").setup({})
        end,
    },
    { "nvimtools/none-ls.nvim",     lazy = true },
    { "jay-babu/mason-null-ls.nvim" },

    {
        "simrat39/rust-tools.nvim",
        config = function()
            require("config.rust-tools").setup({})
        end,
    },

    require("plugins.snip"),
    -- CMP
    {
        "hrsh7th/nvim-cmp",
        config = function()
            require("config.cmp").setup({})
        end,
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            "cmp-nvim-lsp",
            "cmp_luasnip",
            "cmp-buffer",
            "cmp-path",
            "cmp-cmdline",
        },
        lazy = true,
    },
    { "hrsh7th/cmp-nvim-lsp",     lazy = true },
    { "saadparwaiz1/cmp_luasnip", lazy = true },
    { "hrsh7th/cmp-buffer",       lazy = true },
    { "hrsh7th/cmp-path",         lazy = true },
    {
        "hrsh7th/cmp-cmdline",
        lazy = true,
    },

    -- Illuminate
    {
        "RRethy/vim-illuminate",
        config = function()
            require("config.illuminate").setup({})
        end,
        event = "User FileOpened",
        lazy = false,
    },

    {
        "lunarvim/bigfile.nvim",
        config = function()
            pcall(function()
                require("bigfile").setup({})
            end)
        end,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        event = { "FileReadPre", "BufReadPre", "User FileOpened" },
    },

    {
        "Exafunction/codeium.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
        },
        config = function()
            require("codeium").setup({})
        end,
    },

    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },

    -- Whichkey
    {
        "folke/which-key.nvim",
        config = function()
            require("config.which-key").setup({})
        end,
        cmd = "WhichKey",
        event = "VeryLazy",
    },

    {
        "peterhoeg/vim-qml",
        event = "BufRead",
        ft = { "qml" },
    },

    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("config.colorizer").setup()
        end,
    },

    {
        "lukas-reineke/headlines.nvim",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = true, -- or `opts = {}`
    },

    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        config = function()
            require("dashboard").setup({
                -- config
            })
        end,
        dependencies = { { "nvim-tree/nvim-web-devicons" } },
    },

    {
        "altermo/ultimate-autopair.nvim",
        event = { "InsertEnter", "CmdlineEnter" },
        opts = {},
    },

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },

    {
        "preservim/tagbar",
    },

    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
    },

    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("config.nvim-surround")
        end,
    },

    {
        "rmagatti/goto-preview",
        config = function()
            require("config.goto-preview").setup({})
        end,
    },

    {
        "stevearc/conform.nvim",
        lazy = false,
        keys = {
            {
                "<leader>f",
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end,
                mode = "",
                desc = "[F]ormat buffer",
            },
        },
        opts = {
            notify_on_error = false,
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
        },
    },

    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup({})
        end,
        lazy = false,
    },

    {
        "liangxianzhe/nap.nvim",
        config = function()
            require("nap").setup({})
        end,
    },

    {
        'stevearc/oil.nvim',
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require "config/oil"
        end,
    },

    {
        "epwalsh/obsidian.nvim",
        lazy = true,
        ft = "markdown",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            workspaces = {
                {
                    name = "personal",
                    path = "~/Documents/Obsidian Vault/",
                },
            },
        },
    }
}

return plugins
