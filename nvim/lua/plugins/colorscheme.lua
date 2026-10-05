return {
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            local background_by_theme = {
                ["gruvbox-dark-hard"] = "dark",
                ["gruvbox-light-hard"] = "light",
            }
            local state_file = vim.fn.expand "~/.local/state/dotfiles/theme"
            local theme = "gruvbox-dark-hard"

            if vim.fn.filereadable(state_file) == 1 then
                theme = vim.fn.readfile(state_file, "", 1)[1] or theme
            end

            vim.o.background = background_by_theme[theme] or "dark"
            require("gruvbox").setup {
                contrast = "hard", -- can be "hard", "soft" or empty string
            }
            vim.cmd [[colorscheme gruvbox]]

            vim.api.nvim_set_hl(0, "DiffAdd", {
                fg = "#1F2F38",
                bg = "#84B97C",
            })
            vim.api.nvim_set_hl(0, "DiffChange", {})
            vim.api.nvim_set_hl(0, "DiffDelete", {
                bold = true,
                cterm = {},
                fg = "#1F2F38",
                bg = "#DC657D",
            })
            vim.api.nvim_set_hl(0, "DiffText", {
                bold = true,
                cterm = {},
                fg = "#1F2F38",
                bg = "#D4B261",
            })
        end,
    },
}
