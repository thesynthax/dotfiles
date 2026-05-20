vim.g.copilot_no_tab_map = true

-- accept suggestion
vim.keymap.set("i", "<C-l>", 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})

-- next suggestion
vim.keymap.set("i", "<C-j>", "<Plug>(copilot-next)")

-- previous suggestion
vim.keymap.set("i", "<C-k>", "<Plug>(copilot-previous)")

-- dismiss suggestion
vim.keymap.set("i", "<C-h>", "<Plug>(copilot-dismiss)")
