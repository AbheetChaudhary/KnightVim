local _general_settings = vim.api.nvim_create_augroup("_general_settings", { clear = true })
vim.api.nvim_create_autocmd("FileType", {pattern = { "qf", "help", "man", "lspinfo" }, command = "nnoremap <silent> <buffer> q :close<CR>", group = _general_settings })
vim.api.nvim_create_autocmd("FileType", {pattern = { "qf" }, command = "set nobuflisted", group = _general_settings })
vim.api.nvim_create_autocmd("TextYankPost", {pattern = { "*" }, command = "silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})", group = _general_settings })

-- this next autocmd used to avoid printing the comment leader on the next
-- comment line. But this is a desired behaviour now. This becomes unwanted
-- again in languages which have different leaders for single and multiline
-- comments and it repeats the single line comment leader. To quickly remove it
-- press CTRL-U in insert mode. But for languages where the single line leader
-- strts with `//` there vim has a builtin formatoption which avoids this
-- behaviour when the single line comment is present after a statement. This is
-- whats currently being used. See `formatoptions` and `fo-table` for more
-- details. 
-- vim.api.nvim_create_autocmd("BufWinEnter", {pattern = { "*" }, command = ":set formatoptions-=cro | :set showtabline=1", group = _general_settings })
vim.api.nvim_create_autocmd("BufWinEnter", {pattern = { "*" }, command = ":set formatoptions+=/ | :set showtabline=1", group = _general_settings })

local _git = vim.api.nvim_create_augroup("_git", { clear = true })
vim.api.nvim_create_autocmd("FileType", { pattern = "gitcommit", command = "setlocal wrap", group = _git })
vim.api.nvim_create_autocmd("FileType", { pattern = "gitcommit", command = "setlocal spell", group = _git })

local _markdown = vim.api.nvim_create_augroup("_markdown", { clear = true })
vim.api.nvim_create_autocmd("FileType", { pattern = "markdown", command = "setlocal wrap | setlocal spell", group = _markdown })

--   augroup _auto_resize
--     autocmd!
--     autocmd VimResized * tabdo wincmd = 
--   augroup end

local _alpha = vim.api.nvim_create_augroup("_alpha", { clear = true })
vim.api.nvim_create_autocmd("User", { pattern = "AlphaReady", command = "set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3", group = _alpha })

-- local _test = vim.api.nvim_create_augroup("_test", { clear = true })
-- vim.api.nvim_create_autocmd("User", { pattern = "CmpReady", command = "echo 'hello, world'", group = _alpha })

-- " if has_key(environ(), 'TMUX')
-- "   augroup tmux_something
-- "     autocmd VimResume  * call system('tmux set status off')
-- "     autocmd VimEnter   * call system('tmux set status off')
-- "     autocmd VimLeave   * call system('tmux set status on')
-- "     autocmd VimSuspend * call system('tmux set status on')
-- "   augroup END
-- " endif

-- "   augroup collumnLimit
-- "   autocmd!
-- "   autocmd BufEnter,WinEnter,FileType scala,java,python
-- "         \ highlight CollumnLimit ctermbg=DarkGrey guibg=DarkGrey
-- "   let collumnLimit = 80 " feel free to customize
-- "   let pattern =
-- "         \ '\%<' . (collumnLimit+1) . 'v.\%>' . collumnLimit . 'v'
-- "   autocmd BufEnter,WinEnter,FileType scala,java,python
-- "         \ let w:m1=matchadd('CollumnLimit', pattern, -1)
-- " augroup END

-- local _python = vim.api.nvim_create_augroup("_python", { clear = true })
-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = { "*.sage", ".pyx", "*.spyx" }, command = "set filetype=python", group = _python })
-- vim.api.nvim_create_autocmd("FileType", { pattern = "python", command = "set tabstop=4 | set shiftwidth=4 | set expandtab | set makeprg=sage -b && sage -t %", group = _python })

-- Autoformat
-- augroup _lsp
--   autocmd!
--   autocmd BufWritePre * lua vim.lsp.buf.formatting()
-- augroup end

-- local cybu = vim.api.nvim_create_augroup("Cybu", { clear = true })
-- vim.api.nvim_create_autocmd("User", {
-- 	pattern = "CybuOpen",
-- 	callback = function()
-- 		-- execute arbitrary lua code here
-- 	end,
-- 	group = cybu,
-- })

-- vim.api.nvim_create_autocmd("User", {
-- 	pattern = "CybuClose",
-- 	callback = function()
-- 		-- execute arbitrary lua code here
-- 	end,
-- 	group = cybu,
-- })
