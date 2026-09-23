return {
	"neovim/nvim-lspconfig", -- provides the server definitions in lsp/*.lua
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/lazydev.nvim", ft = "lua", opts = {} }, -- lua_ls awareness of the neovim runtime & plugins
	},
	config = function()
		local keymap = vim.keymap -- for conciseness

		-- set keymaps when an lsp attaches to a buffer
		-- (neovim 0.11 already provides K, [d, ]d, grn, gra, grr, gri, gO by default)
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
			callback = function(ev)
				local function map(mode, lhs, rhs, desc)
					keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
				end

				map("n", "gR", "<cmd>Telescope lsp_references<CR>", "Show LSP references")
				map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
				map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", "Show LSP definitions")
				map("n", "gI", "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations")
				map("n", "gy", "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions")
				map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "See available code actions")
				map("n", "<leader>rn", vim.lsp.buf.rename, "Smart rename")
				map("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics")
				map("n", "<leader>d", vim.diagnostic.open_float, "Show line diagnostics")
				map("n", "<leader>rs", "<cmd>LspRestart<CR>", "Restart LSP")
			end,
		})

		-- Change the Diagnostic symbols in the sign column (gutter)
		local severity = vim.diagnostic.severity
		vim.diagnostic.config({
			signs = {
				text = {
					[severity.ERROR] = " ",
					[severity.WARN] = " ",
					[severity.HINT] = "󰠠 ",
					[severity.INFO] = " ",
				},
			},
		})

		-- used to enable autocompletion (applies to every lsp server)
		vim.lsp.config("*", {
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})

		-- configure typescript server
		vim.lsp.config("ts_ls", {
			settings = {
				typescript = {
					referencesCodeLens = {
						enabled = true,
					},
					showOnAllFunctions = {
						enabled = true,
					},
				},
			},
		})

		-- configure graphql language server
		vim.lsp.config("graphql", {
			filetypes = { "graphql", "typescriptreact", "javascriptreact" },
		})

		-- enable servers (definitions come from nvim-lspconfig, binaries from mason)
		vim.lsp.enable({
			"cssls",
			"eslint", -- js/ts linting (diagnostics + code actions)
			"graphql",
			"html",
			"lua_ls",
			"marksman", -- markdown
			"mdx_analyzer",
			"ts_ls",
			"yamlls",
		})
	end,
}
