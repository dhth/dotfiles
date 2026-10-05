vim.opt_local.formatprg = "shfmt -ln bash"

vim.keymap.set(
    "n",
    "f<C-f>",
    ":%!shfmt -ln bash -i 4<CR>",
    { buffer = true, silent = true }
)
