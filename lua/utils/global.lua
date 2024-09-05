local global = {}

function global:get_runtime_dir()
    return vim.fn.stdpath("data")
end

function global:get_plugins_dir()
    return global:get_runtime_dir() .. "/site/pack/lazy/opt/"
end

return global
