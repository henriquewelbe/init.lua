function SetTheme(color)
	color = color or "midnight"
	vim.cmd.colorscheme(color)
end

return {
	{
		"dasupradyumna/midnight.nvim",
		name = "midnight",
		lazy = false,
		priority = 1000,
		config = function()
			SetTheme()
		end
	}
}
