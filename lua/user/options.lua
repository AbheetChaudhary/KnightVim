local options = {
  backup = false,                          -- creates a backup file
  clipboard = "",               -- allows neovim to access the system clipboard
  cmdheight = 1,                           -- more space in the neovim command line for displaying messages
  completeopt = {"menu", "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  fileencoding = "utf-8",                  -- the encoding written to a file
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  mouse = "a",                             -- allow the mouse to be used in neovim
  pumheight = 10,                          -- pop up menu height
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 0,                         -- always show tabs
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeoutlen = 1000,                       -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  updatetime = 200,                       -- faster completion (4000ms default)
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  tabstop = 2,                             -- insert 2 spaces for a tab
  cursorline = true,                       -- highlight the current line
  number = true,                           -- set numbered lines
  laststatus = 3,
  autoindent = false,
  showcmd = false,
  ruler = false,
  relativenumber = true,                   -- set relative numbered lines
  numberwidth = 4,                         -- set number column width to 2 {default 4}
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  wrap = false,                            -- display lines as one long line
  scrolloff = 8,                           -- is one of my fav
  sidescrolloff = 8,
  guifont = "JetBrainsMono Nerd Font:h7",               -- the font used in graphical neovim applications like neovide
  title = true,
  lazyredraw = true,

}

-- CodeActionMenu
-- vim.g.code_action_menu_window_border = "single"
-- vim.g.code_action_menu_show_details = false
-- vim.g.code_action_menu_show_diff = true
-- vim.g.code_action_menu_show_action_kind = false

-- Conjure
-- https://github.com/Olical/conjure/issues/472
vim.cmd('let g:conjure#filetypes = ["scheme"]')
vim.cmd('let g:conjure#filetype#rust = v:false')
vim.cmd('let g:conjure#filetype#clojure = v:false')
vim.cmd('let g:conjure#filetype#fennel = v:false')
vim.cmd('let g:conjure#filetype#janet = v:false')
vim.cmd('let g:conjure#filetype#hy = v:false')
vim.cmd('let g:conjure#filetype#racket = v:false')
vim.cmd('let g:conjure#filetype#lua = v:false')
vim.cmd('let g:conjure#filetype#lisp = v:false')
vim.cmd('let g:conjure#filetype#python = v:false')

vim.opt.fillchars = vim.opt.fillchars + 'eob: '
vim.opt.fillchars:append {
  stl = ' ',
}

vim.opt.shortmess:append "c"

for key, value in pairs(options) do
  vim.opt[key] = value
end

vim.cmd('set whichwrap+=<,>,[,],')
vim.cmd('set iskeyword+=-')
vim.cmd('filetype plugin indent on')
vim.cmd('filetype indent on')

vim.filetype.add {
  extension = {
    conf = "dosini",
  },
}
