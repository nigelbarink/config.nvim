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
            -- Godot Config
            dap.adapters.godot = {
                type = "server",
                host = "127.0.0.1",
                port = 6006
            }
            --dap.configurations.gdscript{
            --    type = "godot",
            --    request = "launch",
            --    name = "launch scene",
            --    project = "${workspaceFolder}"
            --}
            -- C/C++ Config 
            dap.configurations.cpp = {
                {
                name = "Launch",
                type= "lldb",
                request = "launch",
                program = function ()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() , 'file')
                end,
                stopOnEntry = false,
                runInTerminal = false,
                }
            }
            dap.adapters.lldb = {
                type = 'server',
                port= "${port}",
                executable = {
                    command = "C:\\Users\\nigel\\AppData\\Local\\nvim-data\\mason\\bin\\codelldb.cmd",
                    args = { "--port", "${port}"}
                },
                name = 'lldb'
            }

            -- Zig configuration
            dap.configurations.zig = {
                name = 'launch',
                type= 'lldb',
                request = 'launch',
                program = '${workspaceFolder}/zig-out/bin/tests.exe',
                cwd = '${workspaceFolder}',
            }
            -- Java configuration
            -- See also ftplugin
            dap.configurations.java = {
              {
                type = 'java',
                request = 'launch',
                name = "Launch file",
                program = "java ${file}",
              }}
            -- Golang config
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
        end
    }
}
