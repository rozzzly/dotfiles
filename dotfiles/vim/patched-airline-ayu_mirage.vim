" custom AirLine pre-application patch
let g:airline_theme_patch_func = 'AirlineThemePatch'
function! AirlineThemePatch(palette)
    if g:airline_theme == 'ayu_mirage'
        " customize error/warning colors
        let s:ER = [ '#ff3333', '#cbccc6', 15, 1, '' ]

        let a:palette.normal.airline_warning = [
            \ s:ER[1], s:ER[0], s:ER[2], s:ER[3]
        \]
        let a:palette.insert.airline_warning =
        \ a:palette.normal.airline_warning
        let a:palette.visual.airline_warning =
        \ a:palette.normal.airline_warning
        let a:palette.replace.airline_warning =
        \ a:palette.normal.airline_warning

        let a:palette.normal.airline_error = [
         \ s:ER[1], s:ER[0], s:ER[2], s:ER[3]
        \]
        let a:palette.insert.airline_error =
        \ a:palette.normal.airline_error
        let a:palette.visual.airline_error =
        \ a:palette.normal.airline_error
        let a:palette.replace.airline_error =
        \ a:palette.normal.airline_error
    endif
endfunction

" load ayu_mirage
let g:airline_theme='ayu_mirage'
