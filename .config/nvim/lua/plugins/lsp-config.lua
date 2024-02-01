-- LSP Configuration & Plugins
return {
  -- Automatically install LSPs, formatters, linters, and DAPs to stdpath for neovim
  {
    "williamboman/mason.nvim",
    config = true
  },

  -- Installs LSPs automatically using Mason.
  -- Translates between lspconfig LSP names and Mason package names.
  -- Ensures LSPs have a good config to pass to the builtin Neovim LSP client.
  {
    "williamboman/mason-lspconfig.nvim",
    config = {
      ensure_installed = {
        -- Automatically installs these LSPs.
        -- Use the shortened names. Shown in light grey in :Mason.
        -- For list of lspconfigs available -> ':h lspconfig-all'
        "pyright",  -- Python: for; go to definition, references, show function signature in hover
        "ruff_lsp", -- Python: Used by none-ls for Formatting, linting
        "lua_ls",
        "terraformls",
      },
    }
  },

  -- nvim-lspconfig is a collection of configs for the Nvim LSP Client.
  -- These configs enable the Nvim LSP Client to connect to the language servers.
  -- It is not the Nvim LSP Client itself. For that, see ':h lspconfig'
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- Must specify the LSPs here in order to use them.
      lspconfig.pyright.setup({})
      lspconfig.ruff_lsp.setup({})
      lspconfig.lua_ls.setup({})
      lspconfig.terraformls.setup({})

      -- Global mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = ev.buf, desc = "LSP: Declaration" })
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf, desc = "LSP: Definition" })
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, { buffer = ev.buf, desc = "LSP: Type definition" })
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = ev.buf, desc = "LSP: References" })
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = ev.buf, desc = "LSP: Implementations" })
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, desc = "LSP: Hover information about the symbol" })

          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, { buffer = ev.buf, desc = "LSP: Add workspace folder" })
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, { buffer = ev.buf, desc = "LSP: Remove workspace folder" })
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, { buffer = ev.buf, desc = "LSP: List workspace folders" })

          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { buffer = ev.buf, desc = "LSP: Rename symbol" })
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, { buffer = ev.buf, desc = "LSP: Code action" })
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
          end, { buffer = ev.buf, desc = "LSP: Format" })
        end,
      })
    end,
  },

  -- Useful status updates for LSP
  -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
  { "j-hui/fidget.nvim", tag = "legacy", opts = {} },

  -- Additional lua configuration, makes nvim stuff amazing!
  { "folke/neodev.nvim" },
}
