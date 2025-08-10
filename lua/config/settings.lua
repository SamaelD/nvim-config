vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.opt.clipboard = "unnamedplus"

vim.opt.showmode = false

vim.opt.breakindent = true
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

vim.opt.signcolumn = "yes"

vim.opt.inccommand = "split"

vim.opt.foldmethod = "expr" -- default is "normal"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- if this option is true and fold method option is other than normal, every time a document is opened everything will be folded.
vim.opt.foldenable = false
vim.opt.foldcolumn = "0"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 1

vim.opt.cursorline = true

vim.opt.mousemoveevent = true

vim.opt.listchars = "eol:↵,trail:~,tab:>-,nbsp:␣"
vim.opt.fillchars = "eob: "

local default_diagnostic_config = {
    signs = {
        active = true,
        values = {
            { name = "DiagnosticSignError", text = "" },
            { name = "DiagnosticSignWarn", text = "" },
            { name = "DiagnosticSignHint", text = "󰌶" },
            { name = "DiagnosticSignInfo", text = "" },
        },
    },
    virtual_text = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
}

vim.diagnostic.config(default_diagnostic_config)
vim.lsp.inlay_hint.enable(true)
