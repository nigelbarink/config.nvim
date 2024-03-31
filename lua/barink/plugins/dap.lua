return {
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            {
                'rcarriga/nvim-dap-ui',
                dependencies = {
                'mfussenegger/nvim-dap',
                'nvim-neotest/nvim-nio',
                },
                config = function ()
                    require("dapui").setup()
                end
            },
            {
                'theHamsta/nvim-dap-virtual-text',
                config = function()
                    require("nvim-dap-virtual-text").setup()
                end
            }

        },
        config = function ()
            local dap = require('dap')
            dap.configurations.java = {
              {
                type = 'java';
                request = 'launch';
                name = "Launch file";
                program = "java ${file}";
              },
            }
        end
    }
}
