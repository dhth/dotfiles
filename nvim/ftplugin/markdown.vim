setlocal syntax=OFF
vnoremap <buffer> <silent> <ENTER> :lua require("custom.helpers.wiki").toggle_visual_checklist()<CR>
vnoremap <buffer> <silent> aq :lua require("custom.helpers.wiki").quotify_visual()<CR>
nnoremap <buffer> <leader>tf :TableFormat<CR>
