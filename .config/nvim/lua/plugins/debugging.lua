-- Debugging
return 
  {
    { 'mfussenegger/nvim-dap' },
    { 'mfussenegger/nvim-dap-python' }, -- The debugger will automatically pick-up another virtual environment if it is activated before neovim is started.
    { 'rcarriga/nvim-dap-ui', requires = {"mfussenegger/nvim-dap"} },
    { 'nvim-neotest/neotest',
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "antoinemadec/FixCursorHold.nvim"
      }},
    {'nvim-neotest/neotest-python'}
  }
