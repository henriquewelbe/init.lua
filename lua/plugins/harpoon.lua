return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")

			harpoon:setup({
				settings = {
					save_on_toggle = true,
					sync_on_ui_close = true,
				},
			})

			vim.keymap.set("n", "<M-i>", function()
				harpoon:list():add()
			end)
			vim.keymap.set("n", "<M-I>", function()
				harpoon:list():prepend()
			end)

			vim.keymap.set("n", "<M-Tab>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)

			for i = 1, 9, 1 do
				vim.keymap.set("n", "<M-" .. i .. ">", function()
					harpoon:list():select(i)
				end)
			end
		end,
	},
}
