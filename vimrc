set tabstop=2
set shiftwidth=2
set noswapfile
set autoread
highlight QuickFixLine ctermbg=black

augroup Go
  autocmd!
  autocmd BufWritePost *.go call GoFmt()
augroup END

function! GoFmt()
  let l:output = system('go fmt ./... 2>&1')
  if v:shell_error == 0
		edit
    cclose
	  call GoTest()
    return
  endif
	call UpdateCopen(l:output)
endfunction

function! GoTest()
  let l:output = system('go test ./... 2>&1')
  if v:shell_error == 0
    cclose
    return
  endif
	call UpdateCopen(l:output)
endfunction

function! UpdateCopen(output)
  let l:cleaned_output = substitute(a:output, '\t', '  ', 'g')
  let l:lines = split(l:cleaned_output, '\n')
  let l:filtered = filter(l:lines, 'match(v:val, "no test files") == -1 && match(v:val, "FAIL") == -1')
  call setqflist([], 'r', {'lines': l:filtered})
  copen
endfunction

