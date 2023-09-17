local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

require('nvim-ts-autotag').setup()

configs.setup({
	ensure_installed = { "c", "lua", "python", "rust", "javascript", "typescript", "vim", "vimdoc", "query", "html", "css", "scss", "json", "markdown", "scheme", "solidity" },
	sync_install = false, -- install languages synchronously (only applied to 'ensure_installed')
	autopairs = {
		enable = true,
	},

	autotag = {
		enable = true,
	},
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true, disable = { "yaml", "python" , "rust"} },
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
		config = { -- add custom commentstrings here. Some languages like Javascript JSX need many arguments inside the table, check it on the nvim-ts-context-commentstring plugin repo
			css = "//%s",
			lua = { __default = "-- %s", __multiline = "--[[ %s ]]" },
		},
	},
})
