local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	ensure_installed = "all", -- one of "all", "maintained"(actively maintained parsers), or a list of languages. But "maintained" got deprecated, so keep poorly maintained ones in "ignore_install"
	sync_install = false, -- install languages synchronously (only applied to 'ensure_installed')
	ignore_install = { "" }, -- List of parsers to ignore installing
	autopairs = {
		enable = true,
	},
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = true,
	},
	indent = { enable = true, disable = { "yaml", "python" , "rust"} },
	rainbow = {
		enable = false,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
		config = { -- add custom commentstrings here. Some languages like Javascript JSX need many arguments inside the table, check it on the nvim-ts-context-commentstring plugin repo
			css = "//%s",
			lua = { __default = "-- %s", __multiline = "--[[ %s ]]" },
		},
	},
})
