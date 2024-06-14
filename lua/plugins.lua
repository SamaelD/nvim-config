local plugins = {
    { "folke/lazy.nvim",       tag = "stable" },
    -- notification plugin
    {
        "rcarriga/nvim-notify",
        lazy = false,
        config = function()
            require("config.nvim-notify")
        end,
    },
    {
        "loctvl842/monokai-pro.nvim",
        config = function()
            vim.cmd('colorscheme monokai-pro')
        end
    },

    -- status line and buffer line
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require("config.lualine").setup {}
        end
    },
    {
        "akinsho/bufferline.nvim",
        config = function()
            require("config.bufferline").setup {}
        end,
        event = { "BufEnter" },
    },

    -- NeoTree
    {
        'nvim-neo-tree/neo-tree.nvim',
        version = '*',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
            'MunifTanjim/nui.nvim',
        },
        cmd = 'Neotree',
        keys = {
            { '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } },
        },
        opts = {
            filesystem = {
                follow_current_file = {
                    enabled = true,
                },
                window = {
                    mappings = {
                        ['\\'] = 'close_window',
                    },
                },
            },
        },
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            local global = require("global")
            local path = global:get_runtime_dir() .. "site/pack/lazy/opt/nvim-treesitter"
            vim.opt.rtp:prepend(path) -- treesitter needs to be before nvim's runtime in rtp
            require("config.treesitter").setup {}
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
    },

    { "nvim-lua/plenary.nvim", cmd = { "PlenaryBustedFile", "PlenaryBustedDirectory" }, lazy = true },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        config = function()
            require("config.telescope").setup({})
        end,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzf-native.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
        },
        event = "VimEnter"
    },

    -- Git
    {
        "rbong/vim-flog",
        cmd = { "Flog" }
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("config.gitsigns").setup {}
        end,
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", config = true },
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            { 'j-hui/fidget.nvim',       opts = {} },
            { 'folke/neodev.nvim',       opts = {} },
        },
        config = function()
            require("config.lsp").setup({})
        end
    },
    { "nvimtools/none-ls.nvim",   lazy = true },

    {
        'simrat39/rust-tools.nvim',
        config = function()
            require("config.rust-tools").setup {}
        end

    },

    -- CMP
    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        config = function()
            require("luasnip.loaders.from_lua").lazy_load {}
            require("luasnip.loaders.from_vscode").lazy_load {}
            require("luasnip.loaders.from_snipmate").lazy_load {}
        end,
        lazy = true,
    },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            require("config.cmp").setup {}
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
            require("config.illuminate").setup {}
        end,
        event = "User FileOpened",
        lazy = false
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
        end
    },

    -- Terminal
    {
        "akinsho/toggleterm.nvim",
        branch = "main",
        config = true,
        cmd = {
            "ToggleTerm",
            "TermExec",
            "ToggleTermToggleAll",
            "ToggleTermSendCurrentLine",
            "ToggleTermSendVisualLines",
            "ToggleTermSendVisualSelection",
        },
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
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup {
                -- config
            }
        end,
        dependencies = { { 'nvim-tree/nvim-web-devicons' } }
    },

    {
        "altermo/ultimate-autopair.nvim",
        event = { "InsertEnter", "CmdlineEnter" },
        opts = {},
    },

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    },

    {
        "preservim/tagbar"
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
        end
    }
}

return plugins
