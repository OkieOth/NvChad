local plugins = {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    config = function ()
      local dap = require("dap")
      local dapui = require("dapui")
      require("core.utils").load_mappings("dap_ui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function ()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function ()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function ()
        dapui.close()
      end
    end
  },
  -- plantuml stuff
  {
    "tyru/open-browser.vim",
    lazy = false,
  },
  {
    "aklt/plantuml-syntax",
    ft = {"plantuml", "puml"},
  },
  {
    "weirongxu/plantuml-previewer.vim",
    ft = {"plantuml", "puml"},
  },
  -- Rust debugging
  {
    "neovim/nvim-lspconfig",
    config = function ()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function()
      return require "custom.configs.rust-tools"
    end,
    config = function (_, _)
      require("rust-tools").setup(opts)
    end
  },
  {
    "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "saecki/crates.nvim",
    ft = {"rust", "toml"},
    config = function(_, opts)
      local crates = require('crates')
      crates.setup(opts)
      crates.show()
    end
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local M = require "plugins.configs.cmp"
      table.insert(M.sources, {name = "crates"})
      return M
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = {"python"},
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "debugpy",
        "black",
        "mypy",
        "ruff",
        "pyright",
        "rust-analyzer"
      },
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui"
    },
    config = function (_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("nvim-dap-python").setup(path)
      require("core.utils").load_mappings("dap_python")
    end
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    ft = "rust",
    dependencies = {
      "mfussenegger/nvim-dap"
    },
    config = function (_, opts)
      require("nvim-dap-virtual-text").setup({
        virt_text_win_col = 80,
        highlight_changed_variables = true,
      })
    end
  }
}

return plugins
