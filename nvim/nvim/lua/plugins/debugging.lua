return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/nvim-nio",
		"williamboman/mason.nvim",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- Install the PHP debug adapter via mason if missing
		local registry = require("mason-registry")
		if not registry.is_installed("php-debug-adapter") then
			local pkg = registry.get_package("php-debug-adapter")
			if pkg then
				pkg:install()
			end
		end

		dap.adapters.php = {
			type = "executable",
			command = vim.fn.stdpath("data") .. "/mason/bin/php-debug-adapter",
		}

		dap.configurations.php = {
			-- to run php right from the editor
			{
				name = "run current script",
				type = "php",
				request = "launch",
				port = 9003,
				cwd = "${fileDirname}",
				program = "${file}",
				runtimeExecutable = "php",
			},
			{
				name = "listen for Xdebug local",
				type = "php",
				request = "launch",
				port = 9003,
			},
		}
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
		dapui.setup()
	end,
}
