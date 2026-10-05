vim.opt_local.syntax = "OFF"

vim.keymap.set("v", "<Enter>", function()
    vim.cmd.normal { "\27", bang = true }
    require("custom.helpers.wiki").toggle_visual_checklist()
end, { buffer = true, silent = true })

vim.keymap.set("v", "aq", function()
    vim.cmd.normal { "\27", bang = true }
    require("custom.helpers.wiki").quotify_visual()
end, { buffer = true, silent = true })

vim.keymap.set("n", "<leader>tf", ":TableFormat<CR>", { buffer = true })
