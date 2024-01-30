-- Debugging
return
{
  {
    'mfussenegger/nvim-dap',
    config = function()
      require('dap-python').setup('~/.virtualenvs/debugpy/bin/python') -- Uses this virtualenv containing debugpy unless it picks up a virtualenv that's already in use.
      require('dap-python').test_runner = 'pytest'
      require('dap.ext.vscode').load_launchjs(nil, {})                 -- By default, load .vscode/launch.json as the project debugging configuration.
      -- require('vim-tmux-navigator').setup()

      local dap = require("dap")
      local dapui = require("dapui")
      local nvim_tree_api = require("nvim-tree.api")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
        nvim_tree_api.tree.close_in_this_tab()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
        nvim_tree_api.tree.open()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
        nvim_tree_api.tree.open()
      end

      -- Debugging Keymaps
      vim.keymap.set('n', '<C-b>', dap.toggle_breakpoint, { silent = true, desc = "Debug: Toggle [B]reakpoint" })
      vim.keymap.set('n', '<C-c>', function() dap.set_breakpoint(vim.fn.input()) end,
        { desc = "Debug: Toggle [C]onditional Breakpoint" })
      vim.keymap.set('n', '<F5>', dap.continue, { desc = "Debug: Start / Continue" }) -- F5 to start / continue debugger
      vim.keymap.set('n', '<F10>', dap.step_over, { desc = "Debug: Step Over" })
      vim.keymap.set('n', '<F11>', dap.step_into, { desc = "Debug: Step Into" })
      vim.keymap.set('n', '<F12>', dap.step_out, { desc = "Debug: Step Out" })
      vim.keymap.set('n', '<F6>', dap.repl.toggle, { desc = "Debug: Toggle REPL" })
      vim.keymap.set('n', 'dl', dap.run_last, { desc = "[D]ebug [L]ast - run last debug configuration again" })
      vim.keymap.set('n', 'dq', [[:lua require'dap'.terminate()<CR> :lua require'dapui'.close()<CR>]],
        { desc = "[D]ebug: [Q]uit" })
    end
  },

  -- Provides a DAP config to nvim-dap to connect nvim-dap to the debupy debugger.
  -- debugpy will automatically pick-up a virtual environment if it is activated
  -- before neovim is started.
  {
    'mfussenegger/nvim-dap-python',
    config = function()
      require('dap-python').setup('~/.virtualenvs/debugpy/bin/python') -- Uses this virtualenv containing debugpy unless it picks up a virtualenv that's already in use.
      require('dap-python').test_runner = 'pytest'
    end
  },

  {
    'rcarriga/nvim-dap-ui',
    config = {
      controls = {
        element = "repl",
        enabled = true,
        icons = {
          disconnect = "",
          pause = "",
          play = "",
          run_last = "",
          step_back = "",
          step_into = "",
          step_out = "",
          step_over = "",
          terminate = ""
        }
      },
      element_mappings = {},
      expand_lines = true,
      floating = {
        border = "single",
        mappings = {
          close = { "q", "<Esc>" }
        }
      },
      force_buffers = true,
      icons = {
        collapsed = "",
        current_frame = "",
        expanded = ""
      },
      layouts = { {
        elements = { {
          id = "scopes",
          size = 0.25
        }, {
          id = "breakpoints",
          size = 0.25
        }, {
          id = "stacks",
          size = 0.25
        }, {
          id = "watches",
          size = 0.25
        } },
        position = "left",
        size = 40
      }, {
        elements = { {
          id = "repl",
          size = 1
        },
        },
        position = "bottom",
        size = 10
      } },
      mappings = {
        edit = "e",
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t"
      },
      render = {
        indent = 1,
        max_value_lines = 100
      }
    }
  },

  {
    'nvim-neotest/neotest',
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim"
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
          }),
        },
      })
      vim.keymap.set('n', "ts", require('neotest').summary.toggle, { silent = true, desc = "[T]est [S]ummary" })
      vim.keymap.set('n', "tf", function() require('neotest').run.run(vim.fn.expand('%')) end,
        { silent = true, desc = "[T]est [F]ile" })
      vim.keymap.set('n', "tF", function() require('neotest').run.run({ vim.fn.expand('%'), strategy = 'dap' }) end,
        { silent = false, desc = "[T]est + Debug [F]ile" }) -- Error expecting luv callback
      vim.keymap.set('n', "tn", require('neotest').run.run, { silent = true, desc = "[T]est [N]earest" })
      vim.keymap.set('n', "tN", function() require('neotest').run.run({ strategy = 'dap' }) end,
        { silent = true, desc = "[T]est + Debug [N]earest" })
      vim.keymap.set('n', "tl", require('neotest').run.run_last, { silent = true, desc = "Run [L]ast Test" })
      vim.keymap.set('n', "tL", function() require('neotest').run.run_last({ strategy = 'dap' }) end,
        { silent = true, desc = "Debug [L]ast Test" })
      vim.keymap.set('n', "to", function() require('neotest').output.open({ enter = true }) end,
        { silent = true, desc = "[T]est [O]utput" })
    end
  },
  { 'nvim-neotest/neotest-python' },
  { 'nvim-dap-virtual-text' } -- Show variable values and types inline.
}