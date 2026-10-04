vim.filetype.add {
    extension = {
        gotmpl = "gotmpl",
    },
    pattern = {
        [".*/git/config"] = "gitconfig",
        [".*/tmux/.*%.conf"] = "tmux",
        [".*/templates/.*%.tpl"] = "helm",
        [".*/templates/.*%.ya?ml"] = "helm",
        ["helmfile.*%.ya?ml"] = "helm",
    },
}
