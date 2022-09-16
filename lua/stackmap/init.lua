local M = {}

-- M.setup =function (opts)
-- 	print("Options", opts)
-- end
--
M.push = function (name, value)
	print("name", name)
	print("value", value)
end

M.pop = function (name)
	
end

-- vim.keymap.set()
-- vim.api.nvim_get_keymap('n')

return M
