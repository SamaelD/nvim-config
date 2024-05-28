local global = {}

function global:get_runtime_dir()
    return vim.call("stdpath", "data")
end

return global
