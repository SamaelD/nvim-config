local function webkit_format_args()
    return '--style={ BasedOnStyle: InheritParentConfig } ' ..
        '--fallback-style="{BasedOnStyle: webkit, IndentWidth: 4, ' ..
        'AlignAfterOpenBracket: AlwaysBreak, AllowShortFunctionsOnASingleLine: None, ' ..
        'AlwaysBreakTemplateDeclarations: Yes, BinPackArguments: false, ' ..
        'BinPackParameters: false, ColumnLimit: 100, FixNamespaceComments: true, ' ..
        'Cpp11BracedListStyle: true, NamespaceIndentation: None, ' ..
        'SpaceAfterTemplateKeyword: false, SpaceBeforeCpp11BracedList: false}"'
end

return {
    {
        "stevearc/conform.nvim",
        lazy = false,
        keys = {
            {
                "<leader>f",
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end,
                mode = "",
                desc = "[F]ormat buffer",
            },
        },
        opts = {
            notify_on_error = false,
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
            formatters_by_ft = {
                -- cpp = { 'cpp_format' },
                c = { "clang_format" },
            },
            formatters = {
                cpp_format = {
                    command = "clang-format",
                    args = webkit_format_args(),
                },
                clang_format = {
                    args = '--style="{BasedOnStyle: llvm, IndentWidth: 4}"',
                },
            },
        },
    },
}
