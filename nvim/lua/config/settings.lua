vim.cmd "syntax enable"
vim.cmd "filetype plugin on"

vim.opt.compatible = false
vim.opt.exrc = true
vim.opt.secure = true
vim.opt.guicursor = "n:blinkon0"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.errorbells = false
vim.opt.belloff = "all"
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.wrapmargin = 0
vim.opt.smartcase = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.expand "~/.vim/undodir"
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.colorcolumn = "0"
vim.opt.showcmd = false
vim.opt.ruler = true
vim.opt.cursorline = true
vim.opt.conceallevel = 0
vim.opt.updatetime = 100
vim.opt.timeoutlen = 300
vim.opt.writebackup = false
vim.opt.wildmenu = true
vim.opt.wildignore:append "**/node_modules/**"
vim.opt.clipboard:append "unnamedplus"
vim.opt.inccommand = "nosplit"
vim.opt.showmode = false
vim.opt.scrolloff = 8
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
vim.opt.foldcolumn = "0"
vim.opt.fillchars:append { vert = " " }
vim.opt.foldlevelstart = 99
vim.opt.hlsearch = false

vim.api.nvim_set_hl(0, "FlashRangeHighlight", {
    fg = "white",
    bg = "red",
    ctermfg = 15,
    ctermbg = 9,
})

require "config.mappings"

vim.opt.laststatus = 3
