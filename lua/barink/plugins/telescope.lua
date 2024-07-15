local os = vim.loop.os_uname().sysname
return {
        {
            "nvim-telescope/telescope.nvim",
            dependencies = {
                {'nvim-lua/plenary.nvim'},
                {
                    'nvim-telescope/telescope-fzf-native.nvim',
                    build ="cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
                }
            },
            config = function()
                require('telescope').setup({})
                require('telescope').load_extension('fzf')
                local builtin = require('telescope.builtin')

                vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
                vim.keymap.set('n', '<leader>fs', builtin.git_files, {})
            end
        }
}
