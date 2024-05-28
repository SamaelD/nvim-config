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
        as = 'monokaipro',
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

    -- Nvim-Tree
    {
        "nvim-tree/nvim-tree.lua",
        keys = { "<leader>e" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("config.nvimtree").setup {}
        end,
        cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFileToggle" },
        event = "User DirOpened",
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
        -- config = function()
        --     require("config.telescope").setup()
        -- end,
        dependencies = { 'nvim-lua/plenary.nvim' },
        -- dependencies = { "telescope-fzf-native.nvim" },
        lazy = true,
        cmd = "Telescope",
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
        lazy = true,
        dependencies = { "mason-lspconfig.nvim", "nlsp-settings.nvim" },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        cmd = { "LspInstall", "LspUninstall" },
        config = function()
            require("mason-lspconfig").setup {}
        end,
        lazy = true,
        event = "User FileOpened",
        dependencies = "mason.nvim",
    },
    { "tamago324/nlsp-settings.nvim", cmd = "LspSettings", lazy = true },
    { "nvimtools/none-ls.nvim",       lazy = true },
    {
        "williamboman/mason.nvim",
        config = function()
            require("config.mason").setup {}
        end,
        cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
        build = function()
            pcall(function()
                require("mason-registry").refresh()
            end)
        end,
        event = "User FileOpened",
        lazy = true,
    },

    -- CMP
    {
        "L3MON4D3/LuaSnip",
        config = function()
            require("luasnip.loaders.from_lua").lazy_load {}
            require("luasnip.loaders.from_vscode").lazy_load {}
            require("luasnip.loaders.from_snipmate").lazy_load {}
        end,
        event = "InsertEnter",
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
        'mrcjkb/rustaceanvim',
        lazy = false,
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
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("config.nvim-surround")
        end
    }
}

return plugins
