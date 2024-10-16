return {
    {
        "stevearc/oil.nvim",
        opt = {
            default_file_explorer = true
        },
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
        end
    }
}
