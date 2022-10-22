-- local colorscheme = "onedark"

-- local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
-- if not status_ok then
-- 	vim.notify("colorscheme " .. colorscheme .. " not found")
-- 	return
-- end
-- -- As long as onedark is the default colorscheme of knightvim you dont need this


require("onedark").setup({
	style = "deep",
  code_style = {
    comments = 'italic',
    keywords = 'italic',
    functions = 'bold',
    strings = 'none',
    variables = 'none'
  },
    -- Lualine options --
  lualine = {
    transparent = false, -- lualine center bar transparency
  },
  colors = {
    grey = '#6b728c', -- default grey color was very dark for comments to be readable
  },
  highlights = {
    rainbowcol1 = {fg = '#f24a24'}, -- this line fixes a first-level-parenthesis issue which makes it impossible to see when the cursor block is on it
    Visual = {bg = "#073975"},  -- earlier highlight color in visual mode was same as Illuminate's highlight color 
  }
})

require("onedark").load()
