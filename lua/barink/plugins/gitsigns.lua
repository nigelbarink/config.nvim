return {
    'lewis6991/gitsigns.nvim',
    config = function()
        local opts = {
            signs = {
                add          = { text = '+' },
                change       = { text = "~" },
                delete       = { text = "_" },
                topdelete    = { text = "-" },
                changedelete = { text = "~" }
            },
            signs_staged = {
                add          = { text = '+' },
                change       = { text = "~" },
                delete       = { text = "_" },
                topdelete    = { text = "-" },
                changedelete = { text = "~" },
                untracked    = { text = "*" },
            },
            signs_staged_enable = true,
            signcolumn = true,
            watch_gitdir = {
                follow_files = true
            },
            auto_attach = true
        }
        require("gitsigns").setup(opts)
    end,
}
