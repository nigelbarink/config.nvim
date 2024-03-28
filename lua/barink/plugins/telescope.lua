local os = vim.loop.os_uname().sysname
return {
        {
            "nvim-telescope/telescope.nvim",
            dependencies = {
                {'nvim-lua/plenary.nvim'},
                {
                    'nvim-telescope/telescope-fzf-native.nvim',
                    build = function () if os == 'Windows_NT' then
                        print("You are on Windows, Idiot!!!")
                       return [[
                                cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release
                                && cmake --build build --config Release 
                                && cmake --install build --prefix build
                                ]]  else
                        return 'make' end
                    end,
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
