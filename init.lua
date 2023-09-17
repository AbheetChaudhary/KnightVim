-- unnecessary optimisation, it may not have been necessary
-- local disabled_built_ins = {
--     "netrw",
--     "netrwPlugin",
--     "netrwSettings",
--     "netrwFileHandlers",
--     "gzip",
--     "zip",
--     "zipPlugin",
--     "tar",
--     "tarPlugin",
--     "getscript",
--     "getscriptPlugin",
--     "vimball",
--     "vimballPlugin",
--     "2html_plugin",
--     "logipat",
--     "rrhelper",
--     "spellfile_plugin",
--     "matchit"
-- }
--
-- for _, plugin in pairs(disabled_built_ins) do
--     vim.g["loaded_" .. plugin] = 1
-- end

vim.opt.shadafile = "NONE" 
vim.opt.shadafile = ""

-- require("user.colorscheme")
require("user.options")
-- require("user.alpha")
require("user.autocommands")
require("user.keymaps")

vim.cmd 'let g:conjure#filetype#rust = v:false'
vim.cmd 'let g:conjure#filetype#python = v:false'
require("user.plugins")
