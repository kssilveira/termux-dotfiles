set tabstop=2
set shiftwidth=2
set noswapfile
set autoread
highlight QuickFixLine ctermbg=black

let g:go_echo_command_info = 0
augroup Go
  autocmd!
  autocmd BufWritePost *.go GoTest! ./...
augroup END

