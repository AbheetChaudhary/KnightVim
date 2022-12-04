vim.cmd([[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200}) 
    autocmd BufWinEnter * :set formatoptions-=cro
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
