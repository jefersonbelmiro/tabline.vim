" File:        tabline.vim
" Description: Clear tabs within terminal vim.

if (exists("g:loaded_tabline_vim") && g:loaded_tabline_vim) || &cp
    finish
endif
let g:loaded_tabline_vim = 1

function! CustomTabline()
    let output = ''
    for i in range(tabpagenr('$'))
        let tab_index = i + 1
        let winnr = tabpagewinnr(tab_index)
        let buflist = tabpagebuflist(tab_index)
        let bufnr = buflist[winnr - 1]
        let bufname = bufname(bufnr)

        let output .= '%' . tab_index . 'T'
        let output .= (tab_index == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
        let output .= (bufname != '' ? ' ' . fnamemodify(bufname, ':t') . ' ' : ' [No Name] ')

        if getbufvar(bufnr, "&mod") 
            let output .= '[+] '
        endif
    endfor

    let output .= '%#TabLineFill#'
    return output

endfunction
set tabline=%!CustomTabline()
