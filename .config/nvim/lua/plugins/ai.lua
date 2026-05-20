--[[return {
	"Exafunction/windsurf.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"saghen/blink.cmp",
	},
	config = function()
		require("codeium").setup({
			enable_cmp_source = false,
			virtual_text = {
				enabled = true,
				key_bindings = {
					accept = "<C-l>",
                    next = "<C-j>",
                    prev = "<C-k>",
					complete = "<C-space>"
				},
			},
			workspace_root = {
				use_lsp = true,
			},
		})
	end,
}]]
return {
	"github/copilot.vim",
	event = "VeryLazy",
	config = function()
		vim.g.copilot_no_tab_map = true
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
	end,
}
