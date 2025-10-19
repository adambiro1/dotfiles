autocmd FileType yaml setlocal ai ts=2 sw=2 et

fu! Mclear()                      "funkcia od aja na zrusenie oznacenia 
  :let @/ = ""
endf
command! Mclear call Mclear()

set number
