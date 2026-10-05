" Deferred legacy yank callback. Shared options now live in config/settings.lua.
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 5000)
augroup END
