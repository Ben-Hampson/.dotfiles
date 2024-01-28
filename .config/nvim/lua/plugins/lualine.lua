-- Set lualine as statusline
return {
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
        disabled_filetypes = {'dapui_breakpoints', 'dapui_watches', 'dapui_stacks', 'dapui_scopes', 'dap-repl'},
        ignore_focus = {'dapui_breakpoints', 'dapui_watches', 'dapui_stacks', 'dapui_scopes', 'dap-repl', 'NvimTree'},
      },
    },
    config = {
      options = {
        theme = "tokyonight"
      }
    }
  }
}
