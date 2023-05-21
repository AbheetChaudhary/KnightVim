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
	-- location of plugins: ~/.local/share/nvim/site/pack/packer/start/
	-- being in "start" folder they start automatically. "Start" folder contains cloned repos of plugins which have "lua" directory in them where all the useful settings reside

	use({ "wbthomason/packer.nvim", commit = "1d0cf98a561f7fd654c970c49f917d74fafe1530" }) -- Have packer manage itself
	-- use({ "nvim-lua/popup.nvim", commit = "b7404d3" }) -- An implementation of the Popup API from vim in Neovim
	use({ "windwp/nvim-autopairs", commit = "7747bbae60074acf0b9e3a4c13950be7a2dff444" }) -- Autopairs, integrates with both cmp and treesitter
	use({ "numToStr/Comment.nvim", commit = "e1fe53117aab24c378d5e6deaad786789c360123" }) -- Easily comment stuff
	use({ "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" })
	use({ "ahmedkhalf/project.nvim", commit = "8c6bad7d22eef1b71144b401c9f74ed01526a4fb" })
	use({ "nvim-lualine/lualine.nvim", commit = "05d78e9fd0cdfb4545974a5aa14b1be95a86e9c9" })
	use({ "akinsho/toggleterm.nvim", commit = "2a787c426ef00cb3488c11b14f5dcf892bbd0bda" })
	use({ "lukas-reineke/indent-blankline.nvim", commit = "018bd04d80c9a73d399c1061fa0c3b14a7614399" })
	use({ "lewis6991/impatient.nvim", commit = "47302af74be7b79f002773011f0d8e85679a7618" })
	use({ "goolord/alpha-nvim", commit = "1838ae926e8d49fe5330d1498ee8289ae2c340bc" })
	-- use({ "antoinemadec/FixCursorHold.nvim", commit = "70a9516" }) -- This is needed to fix lsp doc highlight
	use({ "nvim-tree/nvim-web-devicons", commit = "986875b7364095d6535e28bd4aac3a9357e91bbe" })
	use({ "nvim-tree/nvim-tree.lua", commit = "736c7ff59065275f0483af4b7f07a9bc41449ad0" })
	use({ "nvim-lua/plenary.nvim", commit = "9ac3e9541bbabd9d73663d757e4fe48a675bb054" }) -- Useful lua functions used by lots of plugins

	-- Colorschemes
	-- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
	use({ "folke/tokyonight.nvim", commit = "29e2c68" })
	use({ "lunarvim/darkplus.nvim", commit = "d308e95" })
	use({ "navarasu/onedark.nvim" })
	use({ "tanvirtin/monokai.nvim" })
	use({ "ellisonleao/gruvbox.nvim" })
	use({ "Mofiqul/dracula.nvim" })
	use({ "NLKNguyen/papercolor-theme" })
	use({ "ofirgall/ofirkai.nvim" })

	-- cmp plugins
	use({ "hrsh7th/nvim-cmp", commit = "3ac8d6cd29c74ff482d8ea47d45e5081bfc3f5ad" }) -- The completion plugin
	use({ "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" }) -- buffer completions
	use({ "hrsh7th/cmp-path", commit = "91ff86cd9c29299a64f968ebb45846c485725f23" }) -- path completions
	use({ "hrsh7th/cmp-cmdline", commit = "5af1bb7d722ef8a96658f01d6eb219c4cf746b32" }) -- cmdline completions
	use({ "saadparwaiz1/cmp_luasnip", commit = "18095520391186d634a0045dacaa346291096566" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp", commit = "0e6b2ed705ddcff9738ec4ea838141654f12eeef" }) -- its an extra source for cmp. Its the [LSP] one
	use({ "hrsh7th/cmp-nvim-lua", commit = "f12408bdb54c39c23e67cab726264c10db33ada8" })
	use({ "PaterJason/cmp-conjure", commit = "d76e1fe5d724afe604dfa7b4b5ba93f3d3730617" }) -- conjure completion for lisp family

	-- snippets
	use({ "L3MON4D3/LuaSnip", commit = "2f78933799ef1a8558057ea7d06d6ccb11140711" }) --snippet engine
	use({ "rafamadriz/friendly-snippets", commit = "28ee6669ab36cab6ff7d3d7f17ecb045e0138e7f" }) -- a bunch of snippets to use

	-- LSP
	use({ "williamboman/mason.nvim", commit = "08b2fd308e0107eab9f0b59d570b69089fd0b522" })
	use({ "williamboman/mason-lspconfig.nvim", commit = "c55d18f3947562e699d34d89681edbf9f0e250d3" })
	use({ "neovim/nvim-lspconfig", commit = "6f1d124bbcf03c4c410c093143a86415f46d16a0" }) -- enable LSP
	use({ "jose-elias-alvarez/null-ls.nvim", commit = "77e53bc3bac34cc273be8ed9eb9ab78bcf67fa48" }) -- for formatters and linters
	use({ "RRethy/vim-illuminate", commit = "a2907275a6899c570d16e95b9db5fd921c167502" }) -- highlight matching texts when cursor is on it

	-- Telescope
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	})
	use({ "nvim-telescope/telescope.nvim", commit = "40c31fdde93bcd85aeb3447bb3e2a3208395a868" })
	use({ "nvim-telescope/telescope-file-browser.nvim", commit = "1aa7f12ce797bb5b548c96f38b2c93911e97c543" }) -- It is useful when changing directories while running live-grep

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		-- run = ":TSUpdate",
		commit = "1557f5cb9abae305c45accd31e8be841f43c907e",
	})

	-- Git
	use({ "lewis6991/gitsigns.nvim", commit = "c18b7ca0b5b50596722f3a1572eb9b8eb520c0f1" })

	-- Debugging
	-- use({ "mfussenegger/nvim-dap", commit = "3d0d731" })
	-- use({ "rcarriga/nvim-dap-ui", commit = "f889edb" })
	-- use({ "ravenxrz/DAPInstall.nvim", commit = "8798b4c" })
	-- use "Pocco81/dap-buddy.nvim"

	use({ "vimwiki/vimwiki", commit = "cd9cfd299ef148721eaef532021c53da3d595710" })
	use({
		"phaazon/hop.nvim",
		commit = "03f0434869f1f38868618198b5f4f2ab6d39aef2",
		branch = "v2", -- optional but strongly recommended
	})
	use({ "tpope/vim-surround", commit = "3d188ed2113431cf8dac77be61b842acb64433d9" })

	-- Rust
	use({ "simrat39/rust-tools.nvim" })
	use({ "elkowar/yuck.vim" })
	-- use({
	-- 	"j-hui/fidget.nvim",
	-- 	config = function()
	-- 		require("fidget").setup()
	-- 	end,
	-- })
	-- use({
	-- 	"weilbith/nvim-code-action-menu",
	-- 	cmd = "CodeActionMenu",
	-- })

	use({
		"uga-rosa/ccc.nvim",
		config = function()
			require("ccc").setup()
		end,
		commit = "78aed26e18a087501be0475443b5a623adbf6290",
	})

	-- lisp
	use({ "gpanders/nvim-parinfer", commit = "c0d95d9f4c5f921872ba11790b76efbb02cc8af5" })
	use({ "Olical/conjure", commit = "1dd96d90f53122225f698e58b50dee9ed760cf2e" })

	-- quick buffer switching
	use({ "ThePrimeagen/harpoon", commit = "8cb54c4003045fe1b690de96638d334de9449546" })
	use({ "matbme/JABS.nvim", commit = "b6dbd1a3e1b8cef3d6ebfafe96c2230ca341b65f" })
	use({ "ghillb/cybu.nvim", commit = "c0866ef6735a85f85d4cf77ed6d9bc92046b5a99" })

	-- use({ "SmiteshP/nvim-navic" })
	-- use({  -- barbecue.lua is still pesent in lua/. Use if ever needed
	-- 	"utilyre/barbecue.nvim",
	-- 	tag = "*",
	-- 	requires = {
	-- 		"SmiteshP/nvim-navic",
	-- 		"nvim-tree/nvim-web-devicons", -- optional dependency
	-- 	},
	-- 	after = "nvim-web-devicons", -- keep this if you're using NvChad
	-- 	config = function()
	-- 		require("user.barbecue")
	-- 	end,
	-- })
	use({ "github/copilot.vim", commit = "1358e8e45ecedc53daf971924a0541ddf6224faf" })

	-- web development
	-- use({ "mattn/emmet-vim" })
	use({ "windwp/nvim-ts-autotag", commit = "40615e96075c743ef47aaf9de966dc348bec6459" })
	use({ "manzeloth/live-server", commit = "2e7dd7db3f59085de2078b53ea50c2f863825784" })

	-- use({ "dccsillag/magma-nvim", commit = "", run = ":UpdateRemotePlugins" })
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
