local plugin_loader = {}

function plugin_loader.init(opts)
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

    if not vim.uv.fs_stat(lazypath) then
        vim.fn.system {
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
        }
    end
    vim.opt.rtp:prepend(lazypath)
end

function plugin_loader.load(configurations)
    plugin_loader:init()
    local lazy_opts = {
        ui = {
            border = "rounded",
            title = "Plugin Manager",
            title_pos = "center",
        },
    }

    require("lazy").setup(configurations, lazy_opts)
end

return plugin_loader
