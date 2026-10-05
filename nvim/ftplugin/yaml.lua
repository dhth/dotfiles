vim.opt_local.cursorcolumn = true

vim.keymap.set(
    "n",
    "f<C-f>",
    ":%!yamlfmt -<CR>",
    { buffer = true, silent = true }
)
