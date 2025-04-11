return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"V13Axel/neotest-pest",
	},
	config = function()
		adapters = {
			require("neotest-pest")({
				dap = { justMyCode = false },
			}),
			ignore_dirs = { "vendor" },
			test_file_suffixes = { "Test.php" },
		}
	end,
}
