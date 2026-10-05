return {
    {
        "mcchrish/nnn.vim",
        init = function()
            vim.g["nnn#set_default_mappings"] = 0
            vim.g["nnn#layout"] = "vnew"
            vim.g["nnn#action"] = {
                ["<c-t>"] = "tab split",
                ["<c-x>"] = "split",
                ["<c-v>"] = "vsplit",
            }
            vim.g["nnn#command"] = 'VISUAL="vi -u NONE" nnn'

            vim.keymap.set("n", "<C-e>", ":NnnPicker %:p:h<CR>", {
                silent = true,
            })
            vim.keymap.set("n", "e<C-e>", ":NnnPicker<CR>", { silent = true })
        end,
    },
}
