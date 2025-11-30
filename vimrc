set tabstop=2
set shiftwidth=2
set noswapfile
highlight QuickFixLine ctermbg=black

function! GoTest()
  let l:output = system('go test ./... 2>&1')
  if v:shell_error == 0
    cclose
    return
  endif
  let l:cleaned_output = substitute(l:output, '\t', '  ', 'g')
  let l:lines = split(l:cleaned_output, '\n')
  let l:filtered = filter(l:lines, 'match(v:val, "no test files") == -1 && match(v:val, "FAIL") == -1')
  call setqflist([], 'r', {'lines': l:filtered})
  copen
endfunction

augroup Go
  autocmd!
  autocmd BufWritePost *.go call GoTest()
augroup END

