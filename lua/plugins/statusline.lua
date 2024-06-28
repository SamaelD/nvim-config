return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup {
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    }
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = { 'filename' },
                    lualine_x = { 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { 'filename' },
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {}
            }
        end
    },
    {
        "akinsho/bufferline.nvim",
        config = function()
            require("bufferline").setup {
                options = {
                    themable = true, -- whether or not bufferline highlights can be overridden externally
                    -- style_preset = preset,
                    get_element_icon = nil,
                    show_duplicate_prefix = true,
                    duplicates_across_groups = true,
                    auto_toggle_bufferline = true,
                    move_wraps_at_ends = false,
                    groups = { items = {}, options = { toggle_hidden_on_enter = true } },
                    mode = "buffers",                        -- set to "tabs" to only show tabpages instead
                    numbers = "none",                        -- can be "none" | "ordinal" | "buffer_id" | "both" | function
                    close_command = "bdelete! %d",
                    right_mouse_command = "vert sbuffer %d", -- can be a string | function, see "Mouse actions"
                    left_mouse_command = "buffer %d",        -- can be a string | function, see "Mouse actions"
                    middle_mouse_command = nil,              -- can be a string | function, see "Mouse actions"
                    indicator = {
                        icon = "▎",
                        style = "icon", -- can also be 'underline'|'none',
                    },
                    buffer_close_icon = "󰅖",
                    modified_icon = " ",
                    close_icon = "",
                    left_trunc_marker = "",
                    right_trunc_marker = "",
                    name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
                        -- remove extension from markdown files for example
                        if buf.name:match "%.md" then
                            return vim.fn.fnamemodify(buf.name, ":t:r")
                        end
                    end,
                    max_name_length = 18,
                    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
                    truncate_names = true,  -- whether or not tab names should be truncated
                    tab_size = 18,
                    diagnostics = "nvim_lsp",
                    diagnostics_update_in_insert = false,
                    offsets = {
                        {
                            filetype = "undotree",
                            text = "Undotree",
                            highlight = "PanelHeading",
                            padding = 1,
                        },
                        {
                            filetype = "NvimTree",
                            text = "Explorer",
                            highlight = "PanelHeading",
                            padding = 1,
                        },
                        {
                            filetype = "DiffviewFiles",
                            text = "Diff View",
                            highlight = "PanelHeading",
                            padding = 1,
                        },
                        {
                            filetype = "flutterToolsOutline",
                            text = "Flutter Outline",
                            highlight = "PanelHeading",
                        },
                        {
                            filetype = "lazy",
                            text = "Lazy",
                            highlight = "PanelHeading",
                            padding = 1,
                        },
                    },
                    color_icons = true, -- whether or not to add the filetype icon highlights
                    show_buffer_icons = true,
                    show_buffer_close_icons = true,
                    show_close_icon = false,
                    show_tab_indicators = true,
                    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
                    -- can also be a table containing 2 custom separators
                    -- [focused and unfocused]. eg: { '|', '|' }
                    separator_style = "thin",
                    enforce_regular_tabs = false,
                    always_show_bufferline = false,
                    hover = {
                        enabled = false, -- requires nvim 0.8+
                        delay = 200,
                        reveal = { "close" },
                    },
                    sort_by = "id",
                    debug = { logging = false },
                }
            }
        end,
        event = { "BufEnter" },
    },
}
