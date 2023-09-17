local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local supported = require("user.supported")

local opts = {
  ui = {
    border = 'rounded',
  },
}

local plugins = {
	{
		"catppuccin/nvim",
    name = "catppuccin",
		lazy = true,
    -- priority = 1000,
    config = function ()
      vim.cmd('colorschem catppuccin')
    end,
	},

	{
		"lunarvim/darkplus.nvim",
		lazy = true,
    -- priority = 1000,
    config = function ()
      vim.cmd('colorschem darkplus')
    end,
	},

	{
		"folke/tokyonight.nvim",
		lazy = true,
    -- priority = 1000,
    config = function ()
      vim.cmd('colorschem tokyonight-moon')
    end,
	},

	{
		"navarasu/onedark.nvim",
		lazy = false,
    priority = 1000,
    config = function ()
      require('user.onedark')
    end,
	},

	{
		"rebelot/kanagawa.nvim",
		lazy = true,
    -- priority = 1000,
    config = function ()
      vim.cmd('colorschem kanagawa-wave')
    end,
	},

	{
		"EdenEast/nightfox.nvim",
		lazy = true,
    -- priority = 1000,
    config = function ()
      vim.cmd('colorschem nordfox')
    end,
	},

	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		priority = 950,
		config = function()
			require("user.alpha")
		end,
	},

	{
		"ahmedkhalf/project.nvim",
		priority = 900,
		config = function()
			require("user.project")
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
    priority = 850,
		config = function()
			require("gitsigns").setup()
		end,
	},

	{
		"ThePrimeagen/harpoon",
		lazy = true,
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("user.harpoon")
		end,
	},

	{
		"williamboman/mason.nvim",
		priority = 800,
		config = function()
			require("mason").setup()
		end,
	},

	{
		"matbme/JABS.nvim",
		event = { "BufAdd", "BufNewFile", "BufRead" },
		cmd = "JABSOpen",
		config = function()
			require("user.jabs")
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
    priority = 750,
		config = function()
			require("user.lualine")
		end,
	},

	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "NvimTreeToggle",
		config = function()
			require("user.nvim-tree")
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		dependencies = "nvim-lua/plenary.nvim",
		-- cmd = "Telescope",
		cmd = "Telescope",
		config = function()
			require("user.telescope")
		end,
	},

	{
		"nvim-telescope/telescope-fzf-native.nvim",
		lazy = true,
		build = "make",
		-- requires = 'nvim-telescope/telescope.nvim',
	},

	{
		"nvim-telescope/telescope-file-browser.nvim",
		lazy = true,
		-- requires = "nvim-telescope/telescope.nvim",
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
		ft = supported.ts,
		config = function()
			require("user.treesitter")
		end,
	},

	{
		"RRethy/vim-illuminate",
		lazy = true,
	},

	{
		"jose-elias-alvarez/null-ls.nvim",
		ft = supported.nullLs,
    commit = "db09b6c691def0038c456551e4e2772186449f35",
		config = function()
			require("user.lsp.null-ls")
		end,
		-- after = "nvim-treesitter",
	},

	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			require("user.cmp")
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"PaterJason/cmp-conjure",
		},
	},

	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		lazy = true,
	},

	{
		"neovim/nvim-lspconfig",
		lazy = true,
		config = function()
			require("user.lsp.nvim-lspconfig")
		end,
		ft = supported.lsp,
		dependencies = "williamboman/mason-lspconfig",
	},

  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    opts = {
      -- options
    },
  },

	{
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = function()
			require("user.hop")
		end,
		event = { "BufAdd", "BufNewFile", "BufRead" },
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("user.comment")
		end,
		event = { "BufAdd", "BufNewFile", "BufRead" },
	},

	{
		"windwp/nvim-autopairs",
		lazy = true,
		config = function()
			require("user.autopairs")
		end,
	},

	{
		"tpope/vim-surround",
		event = { "BufAdd", "BufNewFile", "BufRead" },
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("user.indentline")
		end,
		event = { "BufAdd", "BufNewFile", "BufRead" },
	},

	-- web-dev
	{
		"windwp/nvim-ts-autotag",
		lazy = true,
	},

	-- lisp family
	{
		"Olical/conjure",
		ft = { "scheme", "fnl" },
	},

	{
		"gpanders/nvim-parinfer",
		ft = { "scheme", "fnl" },
	},
}

require("lazy").setup(plugins, opts)
