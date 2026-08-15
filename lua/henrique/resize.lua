local fullscreen_restore = nil

vim.keymap.set("n", "<leader>f", function()
	if fullscreen_restore then
		vim.cmd(fullscreen_restore)
		fullscreen_restore = nil
	else
		fullscreen_restore = vim.fn.winrestcmd()

		vim.cmd("vertical resize 999")
		vim.cmd("resize 999")
	end
end)

local function get_split_direction(layout, win)
	if layout[1] == "leaf" then
		return layout[2] == win
	end

	for _, child in ipairs(layout[2]) do
		local found, direction = get_split_direction(child, win)

		if found then
			return true, direction or layout[1]
		end
	end

	return false
end

local function resize_split(amount)
	local win = vim.api.nvim_get_current_win()
	local _, direction = get_split_direction(vim.fn.winlayout(), win)

	if direction == "row" then
		vim.cmd("vertical resize " .. (amount > 0 and "+" or "") .. amount)
	elseif direction == "col" then
		vim.cmd("resize " .. (amount > 0 and "+" or "") .. amount)
	end
end

vim.keymap.set("n", "<C-_>", function()
	resize_split(-3)
end)

vim.keymap.set("n", "<C-S-=>", function()
	resize_split(3)
end)

vim.keymap.set("n", "<leader>=", "<C-w>=")
