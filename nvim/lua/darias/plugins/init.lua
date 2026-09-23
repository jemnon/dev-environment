return {
	"nvim-lua/plenary.nvim", -- lua functions that many plugins use

	{ "github/copilot.vim", event = "InsertEnter", cmd = "Copilot" },

	"christoomey/vim-tmux-navigator", -- tmux & split window navigation

	{
		-- replace with register contents using motion (gs + motion)
		-- (moved off gr, which neovim 0.11 uses for its default lsp keymaps)
		"inkarkat/vim-ReplaceWithRegister",
		keys = {
			{ "gs", "<Plug>ReplaceWithRegisterOperator", desc = "Replace with register (motion)" },
			{ "gss", "<Plug>ReplaceWithRegisterLine", desc = "Replace line with register" },
			{ "gs", "<Plug>ReplaceWithRegisterVisual", mode = "x", desc = "Replace selection with register" },
		},
	},
}
