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
            java = { "clang-format", stop_after_first = true },
        },
        format_on_save = { timeout_ms = 500 },
        default_format_ops = {
            lsp_format = "fallback"
        },
    },
    config = function ()
       require("conform").setup()
       -- Command to run async formatting 
      vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end
          require("conform").format({ async = true, lsp_format = "fallback", range = range })
       end, { range = true })


    end
}

