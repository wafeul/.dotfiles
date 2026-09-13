return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},

		config = function()
			require("codecompanion").setup({
				interactions = {
					chat = {
						adapter = {
							name = "opencode",
						},
					},
				},
			})
		end,
	},
}
