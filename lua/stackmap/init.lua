local M = {}

-- M.setup =function (opts)
-- 	print("Options", opts)
-- end
--


local find_mapping = function(maps, lhs)
	for _, keymap in ipairs(maps) do
		if keymap.lhs == lhs
			then
				return keymap;
		end
	end
end

M._stack = {}

M.push = function (name, mode, mappings)
	local maps = vim.api.nvim_get_keymap(mode)
	local existing_maps = {}

	for lhs, rhs in pairs(mappings) do
		local existing = find_mapping(maps, lhs)
		if existing then
			table.insert(existing_maps, existing)
		end
	end

	M._stack[name] = existing_maps
	for lhs, rhs in pairs(mappings) do
		vim.keymap.set(mode, lhs, rhs)
	end
	-- vim.keymap.set(mode, mappings)
	-- P(maps)
end


M.pop = function (name)
	for lhs, rhs in pairs(M_.existing_maps) do
		vim.keymap.set(mode, lhs, rhs)
	end
	
end

M.push('debug_mode', 'n' , {
	[" st"] = "echo Hello",
	[" sz"] = "echo Goodbye",
	[" w"] = "echo Write",
	[" t"] = "<Plug>PlenaryTestFile"
})
-- vim.keymap.set()
-- vim.api.nvim_get_keymap('n')
-- vim.api.nvim_get_keymap('n')

return M
