local wc = {}

local mappings = {
    t = {
        name = "Terminal",
        o = { "<cmd>ToggleTerm<cr>", "Open terminal" },
    },
    s = {
        name = "Search",
        f = { "<cmd>Telescope find_files<cr>", "Find files" },
        t = { "<cmd>Telescope live_grep<cr>", "Text search" },
        b = { "<cmd>Telescope buffers<cr>", "Find buffers" },
        h = { "<cmd>Telescope help_tags<cr>", "Help tags" },
    },
    ["T"] = { "<cmd>TagbarToggle<cr>", "Tags" }
}

function wc:setup()
    local which_key = require "which-key"
    which_key.setup {}

    local opts = {
        mode = "n",     -- NORMAL mode
        prefix = "<leader>",
        buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true,  -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true,  -- use `nowait` when creating keymaps
    }

    which_key.register(mappings, opts)
end

return wc
