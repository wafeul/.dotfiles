return {
	{
		"nvimtools/none-ls.nvim",
		lazy = false,
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.shfmt,
					null_ls.builtins.diagnostics.phpcs.with({
						method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
					}),
					-- null_ls.builtins.formatting.phpcsfixer.with({
					--     extra_args = {"--config", "/home/rbourgeas/.config/nvim/externals/phpcsfixer.php"},
					-- }),
					null_ls.builtins.formatting.pretty_php,
					null_ls.builtins.formatting.prettierd,
					null_ls.builtins.diagnostics.hadolint,
				},
			})
		end,
	},

	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = {
					"shfmt",
					"stylua",
					"hadolint",
					"prettierd",
					"phpcs",
					-- "phpcsfixer",
					"pretty-php",
				},
				handlers = {},
			})
		end,
	},
}
