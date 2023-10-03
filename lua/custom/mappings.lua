local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Toggle breakpoint"
    }
  }
}

M.dap_ui = {
  n = {
    ["<leader>dut"] = {
      function ()
      	require("dapui").toggle()
      end
    }
  }
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function ()
        require("dap-python").test_method()
      end
    }
  }
}

M.crates = {
  n = {
    ["<leader>rcu"] = {
      function ()
        require('crates').upgrade_all_crates()
      end,
      "Update all crates"
    }
  }
}

return M
