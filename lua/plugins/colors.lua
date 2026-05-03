function RemoveBg() 
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
    vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
    vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
end

function SetTheme(color)
	-- color = color or "github_dark_high_contrast"
	color = color or "midnight"
	-- color = color or "oldschool"
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
            RemoveBg()
		end
	},
    {
        'projekt0n/github-nvim-theme',
        name = 'github_dark_high_contrast',
        lazy = true,
        -- priority = 1000,
        config = function ()
            SetTheme()
            -- RemoveBg()
        end
    },
    {
        "L-Colombo/oldschool.nvim",
        name = 'oldschool',
        config = true,
    }
}
