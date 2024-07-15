Cmd = 'c:/Users/nigel/Appdata/Local/nvim-data/mason/bin/jdtls.cmd'
JavaDebug = vim.fn.glob("C:/Users/nigel/AppData/Local/nvim-data/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.52.0.jar", 1)
local config = {
    cmd = {Cmd},
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
    init_options = {
        bundles = {
            JavaDebug
        }
    }
}
require('jdtls').start_or_attach(config)
require('jdtls').setup_dap({hotcodreplace='auto'})
require('jdtls.dap').setup_dap_main_class_configs()
