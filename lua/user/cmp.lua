local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	print("CMP instance failed to start! Returning...")
	return
end

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	print("Could not find luasnip...")
	return
end

luasnip.config.set_config({
  updateevents = "TextChanged,TextChangedI",
})

-- html snippets in javascript and javascriptreact
luasnip.snippets = {
	html = {},
}
luasnip.snippets.javascript = luasnip.snippets.html
luasnip.snippets.typescript = luasnip.snippets.html
luasnip.snippets.javascriptreact = luasnip.snippets.html
luasnip.snippets.typescriptreact = luasnip.snippets.html

luasnip.filetype_extend("javascript", { "javascriptreact" })
luasnip.filetype_extend("javascript", { "html" })

luasnip.filetype_extend("typescript", { "javascriptreact" })
luasnip.filetype_extend("typescript", { "html" })

require("luasnip/loaders/from_vscode").load({ include = { "html" } })
require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local kind_icons = {
	Text = "󰉿",
	Method = "󰆧",
	Function = "󰊕",
	Constructor = "",
	Field = " ",
	Variable = "󰀫",
	Class = "󰠱",
	Interface = "",
	Module = "",
	Property = "󰜢",
	Unit = "󰑭",
	Value = "󰎠",
	Enum = "",
	Keyword = "󰌋",
	Snippet = "",
	Color = "󰏘",
	File = "󰈙",
	Reference = "",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "󰏿",
	Struct = "",
	Event = "",
	Operator = "󰆕",
	TypeParameter = " ",
	Misc = " ",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

local ELLIPSIS_CHAR = "…"
local MAX_LABEL_WIDTH = 24
local MIN_LABEL_WIDTH = 24

cmp.setup({
	enabled = function()
		-- disable completion in comments and prompts
		local context = require("cmp.config.context")
		-- keep command mode completion enabled when cursor is in a comment
		if vim.api.nvim_get_mode().mode == "c" then
			return true
		elseif vim.bo.buftype == "prompt" then
			return false
		else
			return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
		end
	end,
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		-- ["<CR>"] = cmp.mapping.confirm({ select = true }),
		-- ["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-y>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.confirm({ select = true })
			elseif luasnip.expandable() then
				luasnip.expand()
			end
		end, {
			"i",
			"s",
		}),
		["<C-l>"] = cmp.mapping(function(fallback)
			if luasnip.choice_active() then
				luasnip.change_choice(1)
			else
				fallback()
			end
		end, {
			"i",
		}),
		["<C-h>"] = cmp.mapping(function(fallback)
			if luasnip.choice_active() then
				luasnip.change_choice(-1)
			else
				fallback()
			end
		end, {
			"i",
		}),
		["<C-j>"] = cmp.mapping(function()
			if luasnip.expandable() then
				luasnip.expand()
      elseif luasnip.jumpable(1) then
        luasnip.jump(1)
			end
		end, {
			"i",
			"s",
		}),
		["<C-k>"] = cmp.mapping(function()
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			end
		end, {
			"i",
			"s",
		}),
		-- ["<Tab>"] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_next_item()
		-- 	elseif luasnip.expandable() then
		-- 		luasnip.expand()
		-- 	elseif luasnip.expand_or_jumpable() then
		-- 		luasnip.expand_or_jump()
		-- 	elseif check_backspace() then
		-- 		fallback()
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, {
		-- 	"i",
		-- 	"s",
		-- }),
		-- ["<S-Tab>"] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_prev_item()
		-- 	elseif luasnip.jumpable(-1) then
		-- 		luasnip.jump(-1)
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, {
		-- 	"i",
		-- 	"s",
		-- }),
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
			-- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				nvim_lua = "[NVIM_LUA]",
				luasnip = "[Snippet]",
				buffer = "[Buffer]",
				path = "[Path]",
        conjure = "[Conjure]",
			})[entry.source.name]

			-- fix width of completion and documentation menu
			local label = vim_item.abbr
			local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
			if truncated_label ~= label then
				vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
			elseif string.len(label) < MIN_LABEL_WIDTH then
				local padding = string.rep(" ", MIN_LABEL_WIDTH - string.len(label))
				vim_item.abbr = label .. padding
			end
			return vim_item
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "buffer", keyword_length = 5 },
		{ name = "path" },
		{ name = "conjure" },
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		documentation = cmp.config.window.bordered(),
		-- completion = cmp.config.window.bordered({ "╭", "─", "╮", "│", "╯", "─", "╰", "│" }),
		-- border can have any single width character
	},
	preselect = cmp.PreselectMode.None, -- select no completion by default
	experimental = {
		ghost_text = false, -- find a way to disable this while writing comments
		native_menu = false,
	},
})

local _cmp = vim.api.nvim_create_augroup("_cmp", { clear = true })
-- vim.api.nvim_create_autocmd("Filetype", {
-- 	pattern = { "scheme" },
-- 	command = "lua require('cmp').setup.buffer{ sources = { { name = 'conjure' }, } }",
-- 	group = _cmp,
-- })
vim.api.nvim_create_autocmd(
	"Filetype",
	{ pattern = "NvimTree", command = "lua require('cmp').setup.buffer { enabled = false }", group = _cmp }
)
