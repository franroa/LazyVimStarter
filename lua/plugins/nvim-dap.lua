return {
  {
    "mfussenegger/nvim-dap",
    lazy = false,
    opts = function()
      local dap = require('dap')
      dap.adapters.go = function(callback, config)
        local port = 38697



        local handle
        local pid_or_err
        handle, pid_or_err =
            vim.loop.spawn(
              "dlv",
              {
                args = { "dap", "-l", "127.0.0.1:" .. port },
                detached = true
              },
              function(code)
                handle:close()
                print("Delve exited with exit code: " .. code)
              end
            )
        -- Mannually start
        -- dlv dap -l 127.0.0.1:38697 --log --log-output="dap"
        -- Wait 100ms for delve to start




        vim.defer_fn(
          function()
            --dap.repl.open()
            callback({ type = "server", host = "127.0.0.1", port = port })
          end,
          100)


        --callback({type = "server", host = "127.0.0.1", port = port})
      end
      dap.configurations.go = {
        {
          type = "go",
          name = "Debug",
          request = "launch",
          program = "${file}"
        },
        {
          type = "go",
          name = "Debug test", -- configuration for debugging test files
          request = "launch",
          mode = "test",
          program = "${file}"
        },
      }
      dap.configurations.python = {
        {
          type = 'python',
          request = 'launch',
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            return '/usr/bin/python'
          end,
        },
      }
    end
  },
}
