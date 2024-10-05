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

                vim.keymap.set('n', '<leader>fd', builtin.find_files, {})
                vim.keymap.set('n', '<leader>ft', builtin.git_files, {})
                vim.keymap.set('n', '<leader>fh', builtin.help_tags)
                vim.keymap.set('n', '<leader>fb', builtin.buffers)
                vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find)
                vim.keymap.set('n', '<leader>gw', builtin.grep_string)
                vim.keymap.set('n', '<leader>fp',function () 
                    builtin.find_files { cwd = "~/.config/nvim/lua/barink/"}
                end)
            end
        }
}
