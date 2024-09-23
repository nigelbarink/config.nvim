local root_files = {
    'premake5.lua',
    '.clang-tidy',
    '.clang-format',
    'compile_commands',
    'compile_commands.json',
    'compile_flags.txt',
    'configure.ac',
    '.git'
}
local util = require('lspconfig.util')
require('lspconfig')['clangd'].setup({
    capabilities = capabilities,
    filetypes= { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
    cmd = { 'clangd' },
    single_file_support = true,
    root_dir = function (fname)
        return util.root_pattern(unpack(root_files))(fname)
    end
})
