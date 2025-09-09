local function find_clang_format_up(path)
	local depth = 0
	local max_depth = 5
	while path ~= "/" and depth < max_depth do
		if vim.fn.filereadable(path .. "/.clang-format") == 1 then
			return true
		end
		path = vim.fn.fnamemodify(path, ":h")
		depth = depth + 1
	end
	return false
end

local function webkit_format_args()
	if find_clang_format_up(vim.fn.getcwd()) then
		return { "--style={BasedOnStyle: InheritParentConfig}" }
	end

	return {
		"--style={BasedOnStyle: webkit, IndentWidth: 4, "
			.. "AlignAfterOpenBracket: AlwaysBreak, AllowShortFunctionsOnASingleLine: None, "
			.. "AlwaysBreakTemplateDeclarations: Yes, BinPackArguments: false, "
			.. "BinPackParameters: false, ColumnLimit: 100, FixNamespaceComments: true, "
			.. "Cpp11BracedListStyle: true, NamespaceIndentation: None, "
			.. "SpaceAfterTemplateKeyword: false, SpaceBeforeCpp11BracedList: false}",
	}
end

local function llvm_format_args()
	if find_clang_format_up(vim.fn.getcwd()) then
		return { "--style={BasedOnStyle: InheritParentConfig}" }
	end

	return {
		"--style={BasedOnStyle: llvm, IndentWidth: 4, "
			.. "AlignAfterOpenBracket: AlwaysBreak, AllowShortFunctionsOnASingleLine: None, "
			.. "AlwaysBreakTemplateDeclarations: Yes, BinPackArguments: false, "
			.. "BinPackParameters: false, ColumnLimit: 100, FixNamespaceComments: true, "
			.. "Cpp11BracedListStyle: true, NamespaceIndentation: None, "
			.. "SpaceAfterTemplateKeyword: false, SpaceBeforeCpp11BracedList: false}",
	}
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
		config = function()
			require("conform").setup({
				notify_on_error = true,
				format_on_save = {
					timeout_ms = 500,
					lsp_format = "fallback",
				},
				formatters_by_ft = {
					cpp = { "cpp_format" },
					c = { "c_format" },
					python = { "isort", "black" },
					lua = { "stylua" },
				},
				formatters = {
					cpp_format = {
						command = "clang-format",
						args = llvm_format_args(),
					},
					c_format = {
						command = "clang-format",
						args = '--style="{BasedOnStyle: llvm, IndentWidth: 4, ColumnLimit: 100,}"',
					},
				},
			})
		end,
	},
}
