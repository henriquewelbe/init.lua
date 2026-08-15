return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*",

		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},

		config = function()
			local actions = require("telescope.actions")
			local builtin = require("telescope.builtin")

			require("telescope").setup({
				defaults = {
					mappings = {
						n = {
							["<M-CR>"] = actions.select_vertical,
							["<M-S-CR>"] = actions.select_horizontal,
							["<M-q>"] = actions.send_to_qflist + actions.open_qflist,
						},
						i = {
							["<M-CR>"] = actions.select_vertical,
							["<M-S-CR>"] = actions.select_horizontal,
							["<M-q>"] = actions.send_to_qflist + actions.open_qflist,
						},
					},
				},
			})

			vim.keymap.set("n", "<M-p>", builtin.find_files, {})
			vim.keymap.set("v", "<M-F>", builtin.grep_string)
			vim.keymap.set("n", "<M-F>", function()
				builtin.live_grep({
					additional_args = { "--fixed-strings" },
				})
			end)
		end,
	},
	{
		"stevearc/quicker.nvim",
		event = "FileType qf",
		opts = {},
		config = function()
			require("quicker").setup({
				vim.keymap.set("n", "<leader>q", function()
					require("quicker").toggle()
				end),
			})
		end,
	},
}
