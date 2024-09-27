return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
        },
        event = "VimEnter",
        config = function()
            require('telescope').setup {
                defaults = {
                    file_ignore_patterns = {
                        '.git/'
                    },
                    layout_strategy = 'flex',
                    sorting_strategy = 'ascending',
                    layout_config = {
                        prompt_position = 'top',
                    },
                },
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown(),
                    },
                    live_grep_args = {
                        auto_quoting = true, -- enable/disable auto-quoting
                    },
                    fzf = {
                        fuzzy = true,                   -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true,    -- override the file sorter
                        case_mode = 'smart_case',       -- or "ignore_case" or "respect_case"
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true,
                    }
                },
                path_display = {
                    filename_first = {
                        reverse_directories = true,
                    },
                },
                mappings = {
                    n = {
                        ["d"] = require("telescope.actions").delete_buffer,
                        ["q"] = require("telescope.actions").close,
                    },
                },
            }

            -- Enable Telescope extensions if they are installed
            pcall(require('telescope').load_extension, 'fzf')
            pcall(require('telescope').load_extension, 'ui-select')
            pcall(require('telescope').load_extension, 'live_grep_args')

            -- See `:help telescope.builtin`
            local builtin = require 'telescope.builtin'
            vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
            vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
            vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
            vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
            vim.keymap.set('n', '<leader>sw', require("telescope-live-grep-args.shortcuts").grep_word_under_cursor,
                { desc = '[S]earch current [W]ord' })
            vim.keymap.set('n', '<leader>sg', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
                { desc = '[S]earch by [G]rep' })
            vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
            vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
            vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
            vim.keymap.set('n', '<leader><leader>',
                function()
                    builtin.buffers({
                        sort_mru = true,
                        sort_lastused = true,
                        initial_mode = 'normal',
                    })
                end,
                { desc = '[ ] Find existing buffers' })
            vim.keymap.set('n', '<leader>tk', builtin.git_commits, { desc = 'Show git history' })
            vim.keymap.set('n', '<leader>k', builtin.git_bcommits, { desc = 'Show git history for an open file' })

            -- Slightly advanced example of overriding default behavior and theme
            vim.keymap.set('n', '<leader>/', function()
                -- You can pass additional configuration to Telescope to change the theme, layout, etc.
                builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, { desc = '[/] Fuzzily search in current buffer' })

            -- It's also possible to pass additional configuration options.
            --  See `:help telescope.builtin.live_grep()` for information about particular keys
            vim.keymap.set('n', '<leader>s/', function()
                builtin.live_grep {
                    grep_open_files = true,
                    prompt_title = 'Live Grep in Open Files',
                }
            end, { desc = '[S]earch [/] in Open Files' })

            -- Shortcut for searching your Neovim configuration files
            vim.keymap.set('n', '<leader>sn', function()
                builtin.find_files { cwd = vim.fn.stdpath 'config' }
            end, { desc = '[S]earch [N]eovim files' })
        end,
    },
}
