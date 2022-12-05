" put space up to nth column
function! s:align(range)

  let target_col = 0
  if exists('g:align_mark')
    let target_col = g:align_mark
  elseif getpos("'k") != [0,0,0,0]
    let target_col = getpos("'k")[2]
  else
    echom 'please set align mark, by exec :AlignMarkCol or set mark in "k"'
    return
  endif

  " generate spaces / backspaces
  let space_num = target_col - virtcol('.')
  if space_num < 0 "abs_space_num handle negative space_num (used in condition in 'while' loop)
    let abs_space_num = space_num * -1
  else
    let abs_space_num = space_num 
  endif
  let ii = 0
  let spaces = ''
  let backspaces = ''
  while ii < abs_space_num
    let spaces = spaces. ' '
    let backspaces = backspaces. '\<bs>'
    let ii += 1
  endwhile

  " execute macro
  if a:range > 0
    call s:align_multiline(space_num, spaces)
    return
  else
    if space_num >= 0
      let macro =  ':SetGranularUndoOff\<cr>i'.spaces.'\<esc>l:SetGranularUndoOn\<cr>'
    else
      let macro =  ':SetGranularUndoOff\<cr>i'.backspaces.'\<esc>l:SetGranularUndoOn\<cr>'
    endif
    let @s= ToRealMacroString(macro)
    normal @s
  endif
endfunction 
:command! -nargs=* -range Align call s:align("<range>")

function! s:align_multiline(space_num, spaces)
  let ii = 0
  let skipped_char = ''
  let skipped_col = getpos("'<")[2]-1
  while ii < skipped_col
    let skipped_char = skipped_char. '.'
    let ii += 1
  endwhile

  " execute macro
  if a:space_num >= 0
    let macro =  ':SetGranularUndoOff\<cr>gv:s/^\('.skipped_char.'\)/\1'.a:spaces.'/g\<cr>:SetGranularUndoOn\<cr>'
  else
    silent echo 'do nothing, this functionality same as using delete with visual mode'
  endif
  let @s= ToRealMacroString(macro)
  normal @s
endfunction 

function! s:align_mark(...)
  let g:align_mark = virtcol('.')
endfunction 
:command! -nargs=* -range AlignMarkCol call s:align_mark()

function! s:align_remove_mark(...)
  unlet g:align_mark
endfunction 
:command! -nargs=* -range AlignRemoveMark call s:align_remove_mark()
