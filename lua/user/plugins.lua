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
	use { "wbthomason/packer.nvim", commit = "6afb674" } -- Have packer manage itself

  -- use { 
  --   "catppuccin/nvim",
  --   as = "catppuccin",
  --   config = function()
  --     require('catppuccin').setup({
  --       flavour = "macchiato",
  --     })
  --     vim.cmd('colorscheme catppuccin')
  --   end,
  -- }

  use { 
    "navarasu/onedark.nvim",
    as = "onedark",
    config = function()
      require('user.colorscheme')
    end,
  }

  use {
    'goolord/alpha-nvim',
    requires = { 'nvim-tree/nvim-web-devicons' },
    after = "onedark",
    config = function ()
      require('user.alpha')
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    event = {"BufReadPre", "BufNewFile"},
    config = function()
      require('user.lualine')
    end,
  }

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional
    },
    cmd = "NvimTreeToggle",
    config = function()
      require('user.nvim-tree')
    end
  }

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { {'nvim-lua/plenary.nvim'} },
    cmd = "Telescope",
    config = function()
      require('user.telescope')
    end,
  }

  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
    -- requires = 'nvim-telescope/telescope.nvim',
  }

  use {
    "nvim-telescope/telescope-file-browser.nvim",
    -- requires = "nvim-telescope/telescope.nvim",
  }

   use {
      "L3MON4D3/LuaSnip",
      event = "InsertEnter",
   }

   use {
      "hrsh7th/nvim-cmp",
      config = function()
        require('user.cmp')
      end,
      after = "LuaSnip",
   }

   use {
      "saadparwaiz1/cmp_luasnip",
      after = "nvim-cmp",
   }

   use {
      "hrsh7th/cmp-nvim-lua",
      after = "nvim-cmp",
   }

   use {
      "hrsh7th/cmp-nvim-lsp",
      after = "nvim-cmp",
   }

   use {
      "hrsh7th/cmp-buffer",
      after = "nvim-cmp",
   }

   use {
      "hrsh7th/cmp-path",
      after = "nvim-cmp",
   }

   use {
      "rafamadriz/friendly-snippets",
      after = "nvim-cmp",
   }

   use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
    end,
    ft = { "c", "lua", "python", "rust", "java", "javascript", "typescript", "vim", "vimdoc", "query" },
    config = function()
      require('user.treesitter')
    end,
  }

  use {
    "jose-elias-alvarez/null-ls.nvim",
    config = function ()
      require('user.lsp.null-ls')
    end,
    after = "nvim-treesitter",
  }

  use {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup()
  end
  }

  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require('user.project')
    end
  }

  use {
    "williamboman/mason.nvim",
    -- after = "nvim-treesitter",
    config = function ()
      require('mason').setup()
    end,
  }

  use {
    "williamboman/mason-lspconfig.nvim",
    -- after = "mason.nvim",
    config = function ()
      require('mason-lspconfig').setup()
    end,
  }

  use {
    "RRethy/vim-illuminate",
    after = "nvim-treesitter",
  }

  use {
    "neovim/nvim-lspconfig",
    after = "cmp-nvim-lsp",
    config = function()
      require('user.lsp.nvim-lspconfig')
    end,
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
        require('user.comment')
    end,
    event = {"BufReadPre", "BufNewFile"},
  }

  use {
    "windwp/nvim-autopairs",
    config = function()
        require('user.autopairs')
    end,
    after = "nvim-cmp",
  }


end)
