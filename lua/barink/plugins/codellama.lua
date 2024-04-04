return {
        {
        'David-kunz/gen.nvim',
        opts = {
            model = "codellama:7b",
            host = "localhost",
            port = "11434",
            quit_mape = "q",
            init = function (options) pcall(io.popen("ollama serve > /dev/null 2>&1 &)"))  end,
            display_mode = "split",
            command =function (options)
            local body = {model = options.model, stream=true}
                return "curl --silent --no-buffer -X POST http://" .. options.host .. ':' .. options.port .. "/api/chat -d $body"
            end,
        },
    }
}
