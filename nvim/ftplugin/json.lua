vim.opt_local.formatprg = "jq"
vim.opt_local.cursorcolumn = true

vim.keymap.set("n", "f<C-f>", ":%!jq '.'<CR>", { buffer = true, silent = true })
vim.keymap.set("n", "<leader>ff", ":%!jq<CR>", { buffer = true, silent = true })
