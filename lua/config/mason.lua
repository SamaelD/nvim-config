local mason = {}

local function add_to_path()
    local p = vim.fn.stdpath("data") .. "/mason/bin"
    if vim.env.PATH:match(p) then
        return
    end
    vim.env.PATH = p .. ":" .. vim.env.PATH
end

function mason:setup()
    add_to_path()

    require("mason").setup{}
end

return mason
