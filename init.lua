vim.loader.enable()

require("settings")

local au = require("autocmds")
au.enable_transparent_mode({})

local plugins = require("plugins")
require("plugins-loader").load({ plugins })

au.setup({})

require("mapping")
-- TODO: check why it doesn't work for lazy.config
require("config.telescope").setup({})
