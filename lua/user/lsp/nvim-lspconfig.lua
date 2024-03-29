-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local pid = vim.fn.getpid()

local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	-- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	-- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	-- vim.keymap.set('n', '<space>wl', function()
	-- print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	-- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)
	vim.keymap.set("n", "gl", vim.diagnostic.open_float, bufopts)
	vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, bufopts)
	-- vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format { async = true }' ]])

	-- Set autocommands conditional on server_capabilities
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		vim.notify("Illumination Failed!....Returning")
		return
	end
	illuminate.on_attach(client)

	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		-- disable virtual text
		virtual_text = false,
		-- show signs
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/publishDiagnostics"] =
		vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { update_in_insert = false })

	-- if client.server_capabilities.documentSymbolProvider then
	-- 	require("nvim-navic").attach(client, bufnr)
	-- end

	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
	end
	if client.name == "lua_ls" then
		client.server_capabilities.documentFormattingProvider = false
	end
	if client.name == "jdtls" then
		client.server_capabilities.documentFormattingProvider = false
	end
	if client.name == "lua_ls" then
		client.server_capabilities.documentFormattingProvider = false
	end
end

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}

-- Add LSP settings in alphabetical order

require("lspconfig")["arduino_language_server"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,

	filetypes = { "arduino" },
})

require("lspconfig")["cssls"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,

	filetypes = { "css", "scss", "less" },
})

require("lspconfig")["clangd"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = require("user.lsp.settings.clangd").capabilities,

	filetypes = { "c", "cpp" },
})

require("lspconfig")["dockerls"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,

	filetypes = { "dockerfile" },
})

require("lspconfig")["gopls"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,

})

require("lspconfig")["hls"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,

	filetypes = { "haskell", "lhaskell", "cabal" },
})

require("lspconfig")["jsonls"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,

	settings = require("user.lsp.settings.jsonls").settings,
	setup = require("user.lsp.settings.jsonls").setup,
})

require("lspconfig")["jdtls"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,

	single_file_support = true,
	settings = {
		java = {
			completion = {
				overwrite = true,
			},
		},
	},
	cmd = { "jdtls" },

	-- cmd = require("user.lsp.settings.jdtls").cmd,
	-- filetypes = require("user.lsp.settings.jdtls").filetypes,
	-- init_options = require("user.lsp.settings.jdtls").init_options,
	-- root_dir = require("user.lsp.settings.jdtls").root_dir,
	-- single_file_support = require("user.lsp.settings.jdtls").single_file_support,
})

require("lspconfig")["kotlin_language_server"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
	filetypes = { "kotlin" },
})

require("lspconfig").omnisharp.setup({
	cmd = { "/home/goliath/.omnisharp/OmniSharp" },
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})

require("lspconfig")["pyright"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,

	settings = require("user.lsp.settings.pyright").settings,
})

require("lspconfig")["rust_analyzer"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,

	cmd = {
		"rustup",
		"run",
		"stable",
		"rust-analyzer",
	},
})

require("lspconfig")["lua_ls"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,

	settings = require("user.lsp.settings.sumneko_lua").settings,
})

require("lspconfig")["tsserver"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,

	preferences = {
		disableSuggestions = true,
	},
})

-- require("user.lsp.null-ls")
