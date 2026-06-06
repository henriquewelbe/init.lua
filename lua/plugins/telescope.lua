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
						-- open file in split view with option+enter
						n = {
							["<M-CR>"] = actions.select_vertical,
						},
						i = {
							["<M-CR>"] = actions.select_vertical,
						},
					},
				},
			})

			vim.keymap.set("n", "<M-p>", builtin.find_files, {})
			vim.keymap.set("v", "<M-F>", builtin.grep_string)
			vim.keymap.set("n", "<M-F>", builtin.live_grep)
		end,
	},
}
