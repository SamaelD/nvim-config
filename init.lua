vim.loader.enable()

require("settings")

local au = require "autocmds"
au.enable_transparent_mode({})

local plugins = require "plugins"
require("plugins-loader").load { plugins }

au.enable_format_on_save({})

au.setup({})

require("mapping")
