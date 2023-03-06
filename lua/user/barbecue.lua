require("barbecue").setup({
	kinds = {
		File = " ",
		Module = " ",
		Namespace = " ",
		Package = " ",
		Class = " ",
		Method = " ",
		Property = " ",
		Field = " ",
		Constructor = " ",
		Enum = "練",
		Interface = "練",
		Function = " ",
		Variable = " ",
		Constant = " ",
		String = " ",
		Number = " ",
		Boolean = "◩ ",
		Array = " ",
		Object = " ",
		Key = " ",
		Null = "ﳠ ",
		EnumMember = " ",
		Struct = " ",
		Event = " ",
		Operator = " ",
		TypeParameter = " ",
	},
	create_autocmd = false, -- prevent barbecue from updating itself automatically
	theme = {
		normal = { fg = "#c0caf5", bg = "#21283b" },

		-- these highlights correspond to symbols table from config
		ellipsis = { fg = "#737aa2" },
		separator = { fg = "#737aa2" },
		modified = { fg = "#737aa2" },

		-- these highlights represent the _text_ of three main parts of barbecue
		dirname = { fg = "#737aa2" },
		basename = { bold = true },
		context = {},
	},
})

vim.api.nvim_create_autocmd({
	"WinScrolled", -- or WinResized on NVIM-v0.9 and higher
	"BufWinEnter",
	"CursorHold",
	"InsertLeave",

	-- include these if you have set `show_modified` to `true`
	"BufWritePost",
	"TextChanged",
	"TextChangedI",
}, {
	group = vim.api.nvim_create_augroup("barbecue.updater", {}),
	callback = function()
		require("barbecue.ui").update()
	end,
})
