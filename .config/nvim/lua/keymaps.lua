-- Keymaps
-- See `:help vim.keymap.set()`

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('i', 'jk', '<esc>', { silent = true })
vim.keymap.set('v', 'jk', '<esc>', { silent = true })
vim.keymap.set('n', 'H', '^', { silent = true })
vim.keymap.set('n', 'L', '$', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Buffer
vim.keymap.set('n', "bn", ":bn<CR>", { silent = true, desc = "Buffer Next"})
vim.keymap.set('n', "bp", ":bp<CR>", { silent = true, desc = "Buffer Previous"})
vim.keymap.set('n', "bq", ":bq<CR>", { silent = true, desc = "Buffer Quit"})

