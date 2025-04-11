return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        -- disable netrw at the very start of your init.lua
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- set termguicolors to enable highlight groups
        vim.opt.termguicolors = true

        -- OR setup with some options
        require("nvim-tree").setup({
            on_config_done = nil,
            sort_by = "name",
            diagnostics = {
                show_on_dirs = false,
                show_on_open_dirs = true,
                debounce_delay = 50,
                severity = {
                    min = vim.diagnostic.severity.HINT,
                    max = vim.diagnostic.severity.ERROR,
                },
                icons = {
                },
            },
            view = {
                adaptive_size = false,
                centralize_selection = true,
                width = 30,
                side = "left",
                preserve_window_proportions = false,
                number = false,
                relativenumber = false,
                signcolumn = "yes",
                float = {
                    enable = false,
                    quit_on_focus_loss = true,
                    open_win_config = {
                        relative = "editor",
                        border = "rounded",
                        width = 30,
                        height = 30,
                        row = 1,
                        col = 1,
                    },
                },
            },
            renderer = {
                add_trailing = false,
                group_empty = false,
                highlight_git = true,
                full_name = false,
                highlight_opened_files = "none",
                root_folder_label = ":t",
                indent_width = 2,
                indent_markers = {
                    enable = false,
                    inline_arrows = true,
                    icons = {
                        corner = "└",
                        edge = "│",
                        item = "│",
                        none = " ",
                    },
                },
                icons = {
                    git_placement = "before",
                    padding = " ",
                    symlink_arrow = " ➛ ",
                },
                special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
                symlink_destination = true,
            },
            filters = {
                dotfiles = true,
                git_clean = false,
                no_buffer = false,
                custom = { "node_modules", "\\.cache" },
                exclude = {},
            },
            on_attach = "default",
            auto_reload_on_write = false,
            disable_netrw = false,
            hijack_cursor = false,
            hijack_netrw = true,
            hijack_unnamed_buffer_when_opening = false,
            prefer_startup_root = false,
            reload_on_bufenter = false,
            respect_buf_cwd = false,
            select_prompts = false,
            hijack_directories = {
                enable = false,
                auto_open = true,
            },
            update_focused_file = {
                enable = true,
                debounce_delay = 15,
                update_root = true,
                ignore_list = {},
            },
            filesystem_watchers = {
                enable = true,
                debounce_delay = 50,
                ignore_dirs = {},
            },
            git = {
                enable = true,
                ignore = false,
                show_on_dirs = true,
                show_on_open_dirs = true,
                timeout = 200,
            },
            actions = {
                use_system_clipboard = true,
            }
        })
    end,
}
