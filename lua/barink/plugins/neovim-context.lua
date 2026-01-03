return {
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = {
        },
        config = function()
            require('treesitter-context').setup({
                enable = true,
                max_lines = 4,
                min_window_height = 0,
                line_numbers = true,
                mode = 'cursor',
            })
        end
    }
}
