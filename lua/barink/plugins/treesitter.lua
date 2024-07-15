return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            {
                "nvim-treesitter/playground",
            },
        },
        config = function()
            require 'nvim-treesitter.install'.compilers = {'clang'}
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                playground  = {
                    enable = true,
                    disable = {},
                    updatetime = 25,
                    keybindings = {
                        toggle_query_editor = 'o',
                        toggle_hl_groups = 'i',
                        update = 'R',
                        show_help = '?'
                    }
                },
                ensure_installed = { "c", "lua", "vim", "vimdoc", "bash" },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
        },
        }
