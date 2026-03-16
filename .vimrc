autocmd FileType yaml setlocal ai ts=2 sw=2 et

fu! Mclear()                      "funkcia od aja na zrusenie oznacenia 
  :let @/ = ""
endf
command! Mclear call Mclear()

autocmd FileType java setlocal ai ts=4 sw=4 et
set relativenumber 
set ruler
set hlsearch
inoremap { {}<Esc>ha
inoremap ( ()<Esc>ha
inoremap [ []<Esc>ha
inoremap " ""<Esc>ha
inoremap ' ''<Esc>ha
inoremap ` ``<Esc>ha
