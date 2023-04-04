vim.cmd([[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200}) 
    autocmd BufWinEnter * :set formatoptions-=cro | :set showtabline=1
    autocmd FileType qf set nobuflisted
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd = 
  augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end

" if has_key(environ(), 'TMUX')
"   augroup tmux_something
"     autocmd VimResume  * call system('tmux set status off')
"     autocmd VimEnter   * call system('tmux set status off')
"     autocmd VimLeave   * call system('tmux set status on')
"     autocmd VimSuspend * call system('tmux set status on')
"   augroup END
" endif

"   augroup collumnLimit
"   autocmd!
"   autocmd BufEnter,WinEnter,FileType scala,java,python
"         \ highlight CollumnLimit ctermbg=DarkGrey guibg=DarkGrey
"   let collumnLimit = 80 " feel free to customize
"   let pattern =
"         \ '\%<' . (collumnLimit+1) . 'v.\%>' . collumnLimit . 'v'
"   autocmd BufEnter,WinEnter,FileType scala,java,python
"         \ let w:m1=matchadd('CollumnLimit', pattern, -1)
" augroup END

 autocmd BufRead,BufNewFile *.sage,*.pyx,*.spyx set filetype=python
 autocmd Filetype python set tabstop=4|set shiftwidth=4|set expandtab
 autocmd FileType python set makeprg=sage\ -b\ &&\ sage\ -t\ %
]])

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
