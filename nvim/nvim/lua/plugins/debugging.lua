return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dap.adapters.php = {
			type = "executable",
			command = "node",
			args = { "~/nvim-config/externals/vscode-php-debug/out/phpDebug.js" },
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
