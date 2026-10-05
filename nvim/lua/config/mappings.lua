local map = vim.keymap.set

-- Tabs. These load after plugin configuration, before custom mappings.
map("n", "<C-t>", ":tabnew<CR>")
map("n", "<leader>mc", ":tabclose<CR>", { silent = true })
map("n", "<BS><BS>", ":tabclose<CR>")
map("n", "<Right>", ":tabnext<CR>", { silent = true })
map("n", "<Left>", ":tabprevious<CR>", { silent = true })

map("v", "<", "<gv")
map("v", ">", ">gv")

-- Karabiner emits these arrows for completion navigation.
map("i", "<Down>", "<C-n>")
map("i", "<Up>", "<C-p>")

map("n", "<leader>>", ":vertical resize +5<CR>", { silent = true })
map("n", "<leader><", ":vertical resize -5<CR>", { silent = true })
map("n", "<leader>q", ":q<CR>", { silent = true })
map("n", "<leader>xx", ":bdelete<CR>", { silent = true })
map("n", "<leader>w", ":silent w<CR>", { silent = true })

map({ "n", "v", "o" }, "<leader>fn", function()
    vim.api.nvim_echo({ { vim.fn.expand "%" } }, false, {})
end)
map(
    { "n", "v", "o" },
    "<leader>cf",
    ":silent !echo -n % | pbcopy<CR>",
    { silent = true }
)

map("n", "<leader>y", "yyp")
map("o", "in(", ":<C-u>normal! f(vi(<CR>")

map("t", "<C-w>h", "<C-\\><C-n><C-w>h")
map("t", "<C-w>j", "<C-\\><C-n><C-w>j")
map("t", "<C-w>k", "<C-\\><C-n><C-w>k")
map("t", "<C-w>l", "<C-\\><C-n><C-w>l")
map("t", "<C-w>z", "<C-\\><C-n><C-w>_")

map("n", "<Up>", ":resize +2<CR>")
map("n", "<Down>", ":resize -2<CR>")
map("i", "<C-l>", "<C-o>a")

map("n", "<leader>ct", ":silent !cat % | pbcopy<CR>", { silent = true })
map("n", "<leader><leader>", ":noh<CR>", { silent = true })
map("n", "<leader>cb", ":verbose nmap <lt>leader>")
map("n", "gp", "`[v`]")
map("n", "v<C-v>", "<C-w><C-v>")
