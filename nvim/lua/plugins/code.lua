return {
    { "nvim-tree/nvim-web-devicons", lazy = true },
    {
        "tpope/vim-unimpaired",
        event = "InsertEnter",
    },
    {
        "azabiong/vim-highlighter",
        event = "InsertEnter",
        init = function()
            vim.cmd [[let HiClear = 'ff<BS>']]
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },
    {
        "vim-scripts/ReplaceWithRegister",
        event = "InsertEnter",
        keys = {
            {
                "er",
                "<Plug>ReplaceWithRegisterOperator",
                desc = "ReplaceWithRegisterOperator",
            },
        },
    },
    {
        "machakann/vim-highlightedyank",
        event = "InsertEnter",
    },
    {
        "farmergreg/vim-lastplace",
    },
    {
        "benmills/vimux",
        event = "InsertEnter",
        dependencies = {
            { "vim-test/vim-test" },
        },
        init = function()
            vim.g.VimuxHeight = "20"
        end,
    },
    {
        "vim-test/vim-test",
        event = "InsertEnter",
    },
    {
        "echasnovski/mini.nvim",
        event = "InsertEnter",
        version = "*",
        config = function()
            require("mini.align").setup()
        end,
    },
    {
        "preservim/vim-markdown",
        event = "InsertEnter",
        dependencies = {
            { "godlygeek/tabular" },
        },
        init = function()
            vim.cmd [[let g:vim_markdown_folding_disabled = 1]]
        end,
    },
    {
        "catgoose/nvim-colorizer.lua",
    },
}
