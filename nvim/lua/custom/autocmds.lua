vim.api.nvim_create_autocmd({ "TermOpen" }, {
    pattern = "*",
    callback = function(_)
        vim.cmd "startinsert"
    end,
})

-- HOCON support for scala conf files
-- https://github.com/antosha417/tree-sitter-hocon
-- https://github.com/lightbend/config/blob/main/HOCON.md
local hocon_group = vim.api.nvim_create_augroup("hocon", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    group = hocon_group,
    pattern = "*/resources/*.conf",
    callback = function(args)
        vim.bo[args.buf].filetype = "hocon"
    end,
})

local jenkinsfile_group =
    vim.api.nvim_create_augroup("jenkinsfile", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    group = jenkinsfile_group,
    pattern = "*Jenkinsfile*",
    callback = function(args)
        vim.bo[args.buf].filetype = "groovy"
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "gitcommit",
    callback = function(args)
        vim.bo[args.buf].bufhidden = "delete"
    end,
})
