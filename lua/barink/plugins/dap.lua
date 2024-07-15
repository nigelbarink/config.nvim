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
            dap.configurations.cpp = {
                {
                name = "Launch",
                type= "codelldb",
                request = "launch",
                program = function ()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() , 'file')
                end,
                cwd = '${workspaceFolder}/Framework',
                stopOnEntry = false,
                }
            }
            dap.configurations.java = {
              {
                type = 'java';
                request = 'launch';
                name = "Launch file";
                program = "java ${file}";
              }}
            dap.configurations.go = {
              {
                type = "delve",
                name = "Debug",
                request = "launch",
                program = "${file}"
              },
              {
                type = "delve",
                name = "Debug test", -- configuration for debugging test files
                request = "launch",
                mode = "test",
                program = "${file}"
              },
              -- works with go.mod packages and sub packages 
              {
                type = "delve",
                name = "Debug test (go.mod)",
                request = "launch",
                mode = "test",
                program = "./${relativeFileDirname}"
              }
            }
            dap.adapters.delve = {
                  type = 'server',
                  port = '${port}',
                  executable = {
                    command = 'dlv',
                    args = {'dap', '-l', '127.0.0.1:${port}'},
                  }
                }
            dap.adapters.codelldb = {
                type= 'server',
                port = '${port}',
                executable = {
                    command = 'C:/Users/Nigel/Appdata/Local/nvim-data/mason/bin/codelldb.cmd',
                    args = {"--port", "${port}"}
                }
            }
        end
    }
}
