set clipboard=unnamed
set mouse=a
set tabstop=4
set backspace=2
syntax on
set number
set expandtab
nnoremap <C-b> <C-v>

let s:clip = '/mnt/c/Windows/System32/clip.exe'
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * call system ('echo '.shellescape(join(v:event.regcontents, "\<CR>")).' | '.s:clip)
    augroup END
end
