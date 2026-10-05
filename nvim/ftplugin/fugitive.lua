vim.keymap.set("n", "<leader><leader>", function()
    require("custom.helpers.git").git_commands()
end, { buffer = true, silent = true })

vim.keymap.set("n", "<leader>gp", function()
    require("custom.helpers.git").git_push()
end, { buffer = true, silent = true })

vim.keymap.set("n", "<C-e>", ":NnnPicker<CR>", { buffer = true, silent = true })
