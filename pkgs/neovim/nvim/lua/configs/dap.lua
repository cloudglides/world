require("dapui").setup()
require("nvim-dap-virtual-text").setup()

local dap, dapui = require("dap"), require("dapui")

dap.listeners.after.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.after.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.after.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.after.event_exited.dapui_config = function()
  dapui.close()
end
