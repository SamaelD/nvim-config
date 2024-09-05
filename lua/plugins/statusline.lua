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
            local bufferline = require('bufferline')
            bufferline.setup {
                options = {
                    mode = "buffers",
                    style_preset = bufferline.style_preset.no_bold,
                    themable = true,
                    indicator = {
                        icon = '▎',
                        style = "icon"
                    },
                    buffer_close_icon = '󰅖',
                    modified_icon = '● ',
                    close_icon = ' ',
                    left_trunc_marker = ' ',
                    right_trunc_marker = ' ',
                    max_name_length = 24,
                    max_prefix_length = 18, -- prefix used when a buffer is de-duplicated
                    truncate_names = true,  -- whether or not tab names should be truncated
                    tab_size = 24,
                    diagnostics = "nvim_lsp",
                    diagnostics_indicator = function(count, level, diagnostics_dict, context)
                        if context.buffer:current() then
                            return ''
                        end
                        local icon = level:match("error") and " " or " "
                        return " " .. icon .. count
                    end,
                    offsets = {
                        {
                            filetype = "neo-tree",
                            text = "File Explorer",
                            text_align = "left",
                            separator = true,
                        }
                    },
                    hover = {
                        enabled = true,
                        delay = 200,
                        reveal = { 'close' }
                    },
                    always_show_bufferline = false,
                    auto_toggle_bufferline = true,
                    separator_style = "thin"
                },
                highlights = {
                    buffer_selected = {
                        italic = true,
                    }
                },
            }
        end,
    },
}
