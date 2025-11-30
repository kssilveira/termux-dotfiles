set tabstop=2
set noswapfile

function! GoTest()
  let l:output = system('go test ./... 2>&1')
  if v:shell_error == 0
    return
  endif
	  let l:cleaned_output = substitute(l:output, '\t', '  ', 'g')
  let l:lines = split(l:cleaned_output, '\n')
	let l:filtered = filter(l:lines, 'match(v:val, "no test files") == -1')
  for l:line in l:filtered
    if empty(l:line)
      continue
    endif
    echomsg l:line
  endfor
endfunction

augroup Go
  autocmd!
  autocmd BufWritePost *.go call GoTest()
augroup END

