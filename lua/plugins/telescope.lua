return {
	{
	    'nvim-telescope/telescope.nvim', version = '*',
	    dependencies = {
		'nvim-lua/plenary.nvim',
		-- optional but recommended
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	    },
	    config = function()
		require('telescope').setup({})
	
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<M-p>', builtin.find_files, {desc = 'Telescope find files'})
		vim.keymap.set('n', '<leader>g', builtin.git_files, {})
		vim.keymap.set('n', '<M-F>', function()
		    builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
	    end
	},
}
