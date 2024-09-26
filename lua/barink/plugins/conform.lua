return {
    "stevearc/conform.nvim",
    event = { "BufWritePre"},
    cmd = { "ConformInfo"},
    opts = {
        formatters_by_ft = {
            php = { "pint"},
            lua = { "stylua"},
            javascript = { "prettierd", "prettier", stop_after_first = true },
            typescript = { "prettierd", "prettier", stop_after_first = true },
        },
        format_on_save = { timeout_ms = 500 },
        default_format_ops = {
            lsp_format = "fallback"
        },
    },
    config = function ()
       require("conform").setup()
    end
}

