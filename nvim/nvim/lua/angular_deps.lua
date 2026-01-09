-- ~/.config/nvim/lua/angular_deps.lua
local M = {}

function M.pick(missing)
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  pickers.new({}, {
    prompt_title = "Install Angular dependencies",
    finder = finders.new_table({
      results = missing,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if selection then
          vim.fn.jobstart({ "npm", "install", selection[1], "--save-dev" }, {
            cwd = vim.fn.getcwd(),
            stdout_buffered = true,
            on_stdout = function(_, data, _)
              if data then
                vim.notify(table.concat(data, "\n"), vim.log.levels.INFO)
              end
            end,
            on_stderr = function(_, data, _)
              if data then
                vim.notify(table.concat(data, "\n"), vim.log.levels.ERROR)
              end
            end,
          })
        end
      end)
      return true
    end,
  }):find()
end

return M
