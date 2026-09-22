return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},

		config = function()
			require("codecompanion").setup({
				adapters = {
					acp = {
						opencode = function()
							return require("codecompanion.adapters").extend("opencode", {
								defaults = {
									mcpServers = "inherit_from_config",
								},
							})
						end,
						codex = function()
							return require("codecompanion.adapters").extend("codex", {
								defaults = {
									auth_method = "chat-gpt",
									mcpServers = "inherit_from_config",
								},
							})
						end,
					},
				},

				interactions = {
					chat = {
						adapter = {
							name = "opencode",
							model = "opencode/big-pickle",
						},
					},
				},

				mcp = {
					servers = {
						gitnexus = {
							cmd = {
								"npx",
								"-y",
								"gitnexus@latest",
								"mcp",
							},
						},
					},
				},
			})
		end,
	},
}
