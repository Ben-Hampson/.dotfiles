-- Treesitter 
--   parses through code using language parsers
--   builds a syntax tree and keeps it updated after every keystroke
--   enables syntax highlighting, folding, and text-object manipulation
return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        auto_install = true,  -- Auto install parsers when opening a file
        highlight = {
          enable = true
        },
        indent = {
          enable = true
        }
      })
    end
  }
}
