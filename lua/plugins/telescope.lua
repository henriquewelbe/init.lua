return {
	{
	    'nvim-telescope/telescope.nvim', version = '*',
	    dependencies = {
		'nvim-lua/plenary.nvim',
		-- optional but recommended
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	    },
	    config = function()

        local actions = require("telescope.actions")
        require('telescope').setup({
            defaults = {
                mappings = {
              n = {
                  ["<M-CR>"] = actions.select_vertical,
              },
              i = {
                  ["<M-CR>"] = actions.select_vertical,
              },
            },
          },
        })
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<M-p>', builtin.find_files, {desc = 'Telescope find files'})
		vim.keymap.set('n', '<leader>g', builtin.git_files, {})
        vim.keymap.set('n', '<M-f>', function()
          builtin.live_grep({ search_dirs={ vim.fn.expand("%:p") } })
        end)
		vim.keymap.set('n', '<M-F>', function()
		    builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
	    end
	},
}

