local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	vim.notify("Packer Protected call failed. Returning...")
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- Format:
	-- user/repo -- Some useful comment
	-- location of plugins: ~/.local/share/nvim/site/pack/packer/start/
	-- being in "start" folder they start automatically. "Start" folder contains cloned repos of plugins which have "lua" directory in them where all the useful settings reside
	-- My plugins here

	use({ "wbthomason/packer.nvim", commit = "6afb674" }) -- Have packer manage itself
	use({ "nvim-lua/popup.nvim", commit = "b7404d3" }) -- An implementation of the Popup API from vim in Neovim
	use({ "windwp/nvim-autopairs", commit = "6b6e35f" }) -- Autopairs, integrates with both cmp and treesitter
	use({ "numToStr/Comment.nvim", commit = "ad7ffa8" }) -- Easily comment stuff
	use({ "akinsho/bufferline.nvim", commit = "028a879" })
	use({ "ThePrimeagen/harpoon", commit = "21d0d1b" })
	use({ "moll/vim-bbye", commit = "25ef93a" })
	use({ "ahmedkhalf/project.nvim", commit = "685bc8e" })
	use({ "nvim-lualine/lualine.nvim", commit = "3325d5d" })
	use({ "akinsho/toggleterm.nvim", commit = "2a787c426ef00cb3488c11b14f5dcf892bbd0bda" })
	--   use "folke/which-key.nvim"
	use({ "lukas-reineke/indent-blankline.nvim", commit = "db7cbcb" })
	use({ "lewis6991/impatient.nvim", commit = "b842e16" })
	use({ "goolord/alpha-nvim", commit = "0bb6fc0" })
	use({ "antoinemadec/FixCursorHold.nvim", commit = "70a9516" }) -- This is needed to fix lsp doc highlight
	use({ "kyazdani42/nvim-web-devicons", commit = "9061e2d" })
	use({ "kyazdani42/nvim-tree.lua", commit = "3845039" })
	use({ "nvim-lua/plenary.nvim", commit = "4b7e520" }) -- Useful lua functions used by lots of plugins

	-- Colorschemes
	-- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
	use({ "folke/tokyonight.nvim", commit = "29e2c68" })
	use({ "lunarvim/darkplus.nvim", commit = "f20cba5" })
	use({
		"navarasu/onedark.nvim",
		-- require('onedark').setup {
		-- style = 'deep'
		-- }
		-- commit = "cad3d98",
	})
  use ({'tanvirtin/monokai.nvim'})
	use({ "morhetz/gruvbox", commit = "bf2885a" })
	-- cmp plugins
	use({ "hrsh7th/nvim-cmp", commit = "9bb8ee6" }) -- The completion plugin
	use({ "hrsh7th/cmp-buffer", commit = "3022dbc" }) -- buffer completions
	use({ "hrsh7th/cmp-path", commit = "91ff86c" }) -- path completions
	use({ "hrsh7th/cmp-cmdline", commit = "c66c379" }) -- cmdline completions
	use({ "saadparwaiz1/cmp_luasnip", commit = "1809552" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp", commit = "78924d1" }) -- its an extra source for cmp. Its the [LSP] one
	use({ "hrsh7th/cmp-nvim-lua", commit = "d276254" })

	-- snippets
	use({ "L3MON4D3/LuaSnip", commit = "663d544" }) --snippet engine
	use({ "rafamadriz/friendly-snippets", commit = "c93311f" }) -- a bunch of snippets to use

	-- LSP
	use({ "neovim/nvim-lspconfig", commit = "67f0d00" }) -- enable LSP
	use({ "williamboman/nvim-lsp-installer", commit = "23820a8" }) -- simple to use language server installer
	use({ "jose-elias-alvarez/null-ls.nvim", commit = "f1add23" }) -- for formatters and linters
	use({ "RRethy/vim-illuminate", commit = "0603e75" }) -- highlight matching texts when cursor is on it

	-- Telescope
	use({ "nvim-telescope/telescope.nvim", commit = "9784730" })
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	})
	use({ "nvim-telescope/telescope-file-browser.nvim" })

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		-- commit = "5d11dfc2",
	})
	use({ "p00f/nvim-ts-rainbow", commit = "064fd6c" })

	-- Git
	use({ "lewis6991/gitsigns.nvim", commit = "9110ea1" })

	-- Debugging
	use({ "mfussenegger/nvim-dap", commit = "3d0d731" })
	use({ "rcarriga/nvim-dap-ui", commit = "f889edb" })
	use({ "ravenxrz/DAPInstall.nvim", commit = "8798b4c" })
	-- use "Pocco81/dap-buddy.nvim"

	-- nvim notify
	use({ "rcarriga/nvim-notify" })

	-- logging
	use({ "Tastyep/structlog.nvim" })

	use({
		"phaazon/hop.nvim",
		commit = "90db1b2",
		branch = "v2", -- optional but strongly recommended
		-- config = function()
		-- 	-- you can configure Hop the way you like here; see :h hop-config
		-- 	require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		-- end,
	})
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
