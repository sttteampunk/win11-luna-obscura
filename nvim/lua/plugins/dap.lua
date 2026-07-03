return {
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")

      -- We use vim.schedule to wait a fraction of a second for nvim-dap-python
      -- to generate its default configurations, then we modify them.
      vim.schedule(function()
        if dap.configurations.python then
          for _, config in ipairs(dap.configurations.python) do
            -- This prevents the blue terminal split and forces output to the DAP UI
            config.console = "internalConsole"
          end
        end
      end)
    end,
  },
}
