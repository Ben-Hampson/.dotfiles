-- Disable netrw because we're using nvim-tree.
-- This should be at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Import modules from ./lua
require("options")
--  NOTE: Keymaps must be loaded before plugins are required. Otherwise wrong leader will be used.
require("keymaps")

-- Install package manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Install Plugins
require('lazy').setup("plugins")

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})


-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'lua', 'python', 'vimdoc', 'vim' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}


-- [[ Configure LSP ]]
-- This function gets run when an LSP connects to a particular buffer.
-- I haven't gotten this function to work inside lua/plugins/lsp-config.lua inside the
-- config function.
-- local on_attach = function(_, bufnr)
--   -- NOTE: Remember that lua is a real programming language, and as such it is possible
--   -- to define small helper and utility functions so you don't have to repeat yourself
--   -- many times.
--   --
--   -- In this case, we create a function that lets us more easily define mappings specific
--   -- for LSP related items. It sets the mode, buffer and description for us each time.
--   local nmap = function(keys, func, desc)
--     if desc then
--       desc = 'LSP: ' .. desc
--     end
--
--     vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
--   end
--
--   nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
--   nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
--
--   nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
--   nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
--   nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
--   nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
--   nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
--   nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
--
--   -- See `:help K` for why this keymap
--   nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
--   nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
--
--   -- Lesser used LSP functionality
--   nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
--   nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
--   nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
--   nmap('<leader>wl', function()
--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--   end, '[W]orkspace [L]ist Folders')
--
--   -- Create a command `:Format` local to the LSP buffer
--   vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
--     vim.lsp.buf.format()
--   end, { desc = 'Format current buffer with LSP' })
-- end
--
-- -- Enable the following language servers
-- --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
-- --
-- --  Add any additional override configuration in the following tables. They will be passed to
-- --  the `settings` field of the server config. You must look up that documentation yourself.
-- local servers = {
--   lua_ls = {
--     Lua = {
--       workspace = { checkThirdParty = false },
--       telemetry = { enable = false },
--     },
--   },
--   pylsp = {},
--   terraformls = {},
-- }
--
--
-- -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- -- Ensure the servers above are installed
-- local mason_lspconfig = require 'mason-lspconfig'
--
-- mason_lspconfig.setup {
--   ensure_installed = vim.tbl_keys(servers),
-- }
--
-- mason_lspconfig.setup_handlers {
--   function(server_name)
--     require('lspconfig')[server_name].setup {
--       capabilities = capabilities,
--       on_attach = on_attach,
--       settings = servers[server_name],
--     }
--   end,
-- }

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

-- Theming
-- Theme setup must come before bufferline setup
require("tokyonight").setup({style = "night"})
vim.cmd[[colorscheme tokyonight]]

-- bufferline
require("bufferline").setup({
  options={
    diagnostics = "nvim_lsp",
    always_show_bufferline = true,
    separator_style = "slant",
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left",
      },
    },
  }
})

-- Debugging Setup
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python') -- Uses this virtualenv containing debugpy unless it picks up a virtualenv that's already in use.
require('dap-python').test_runner = 'pytest'
require('dap.ext.vscode').load_launchjs(nil, {}) -- By default, load .vscode/launch.json as the project debugging configuration.
require('dapui').setup(
  {
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
)
require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
    }),
  },
})



-- Run dap-ui when a debugging session is started
local dap = require("dap")
local dapui = require("dapui")
local nvim_tree_api = require("nvim-tree.api")
dap.listeners.after.event_initialized["dapui_config"]=function()
  dapui.open()
  nvim_tree_api.tree.close_in_this_tab()
end
dap.listeners.before.event_terminated["dapui_config"]=function()
  dapui.close()
  nvim_tree_api.tree.open()
end
dap.listeners.before.event_exited["dapui_config"]=function()
  dapui.close()
  nvim_tree_api.tree.open()
end

-- Breakpoint Symbols
vim.fn.sign_define('DapBreakpoint',{ text =' ', texthl ='', linehl ='', numhl =''})
vim.fn.sign_define('DiagnosticWarn',{ text =' ', texthl ='', linehl ='', numhl =''})
vim.fn.sign_define('DapStoppedLine',{ text =' ', texthl ='', linehl ='', numhl =''})
vim.fn.sign_define('DapBreakpoint',{ text =' ', texthl ='', linehl ='', numhl =''})
vim.fn.sign_define('DapStopped',{ text ='󰁕 ', texthl ='', linehl ='', numhl =''})
vim.fn.sign_define('BreakpointCondition',{ text =' ', texthl ='', linehl ='', numhl =''})
vim.fn.sign_define('BreakpointRejected',{ text =' ', texthl ='', linehl ='', numhl =''})
vim.fn.sign_define('DiagnosticError',{ text =' ', texthl ='', linehl ='', numhl =''})

-- Debugging Keymaps
-- Press CTRL + b to toggle regular breakpoint
vim.keymap.set('n', '<C-b>', require'dap'.toggle_breakpoint, {})
-- Press CTRL + c to toggle Breakpoint with Condition
vim.keymap.set('n', '<C-c>', function() require'dap'.set_breakpoint(vim.fn.input('Breakpoint Condition: ')) end, {})
-- F5 to start / continue debugger
vim.keymap.set('n', '<F5>', require'dap'.continue, {})
-- Pressing F10 to step over
vim.keymap.set('n', '<F10>', require'dap'.step_over, {})
-- Pressing F11 to step into
vim.keymap.set('n', '<F11>', require'dap'.step_into, {})
-- Pressing F12 to step out
vim.keymap.set('n', '<F12>', require'dap'.step_out, {})
-- Press F6 to open REPL
vim.keymap.set('n', '<F6>', require'dap'.repl.toggle, {})
-- Press dl to run last ran configuration (if you used f5 before it will re run it etc)
vim.keymap.set('n', 'dl', require'dap'.run_last, { desc = "[D]ebug [L]ast" })
-- Press dq to quit
vim.keymap.set('n', 'dq', [[:lua require'dap'.terminate()<CR> :lua require'dapui'.close()<CR>]], { desc = "[D]ebug [Q]uit" })

-- neotest Keymaps
vim.keymap.set('n', "ts", require('neotest').summary.toggle, {silent = true, desc = "[T]est [S]ummary"})
vim.keymap.set('n', "tf", function() require('neotest').run.run(vim.fn.expand('%')) end, {silent = true, desc = "[T]est [F]ile"})
vim.keymap.set('n', "tF", function() require('neotest').run.run({vim.fn.expand('%'), strategy='dap' }) end, {silent = false, desc = "[T]est + Debug [F]ile"}) -- Error expecting luv callback
vim.keymap.set('n', "tn", require('neotest').run.run, {silent = true, desc = "[T]est [N]earest"})
vim.keymap.set('n', "tN", function() require('neotest').run.run({ strategy='dap' }) end, { silent = true, desc = "[T]est + Debug [N]earest"})
vim.keymap.set('n', "tl", require('neotest').run.run_last, { silent = true, desc = "Run [L]ast Test"})
vim.keymap.set('n', "tL", function() require('neotest').run.run_last({ strategy='dap' }) end, { silent = true, desc = "Debug [L]ast Test"})
vim.keymap.set('n', "to", function() require('neotest').output.open({ enter=true }) end, { silent = true, desc = "[T]est [O]utput"})


require("diagnostics")

require('gitsigns').setup()

-- Setup neovim lua configuration
require('neodev').setup()
