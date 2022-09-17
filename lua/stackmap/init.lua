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
			existing_maps[lhs] = existing
			table.insert(existing_maps, existing)
		end
		vim.keymap.set(mode, lhs, rhs)
	end

	M._stack[name] = {
		existing = existing_maps,
		mappings = mappings,
		mode = mode,
	}
	-- vim.keymap.set(mode, mappings)
	-- P(maps)
end


M.pop = function (name)
	local state = M._stack[name];
	if state == nil then
		return
	end
	local existing = state.existing
	local mappings = state.mappings

	M._stack[name] = nil

	for lhs, _ in pairs(mappings) do
		if  existing[lhs] then
			vim.keymap.set(state.mode, lhs, existing[lhs].rhs)
		else
			vim.keymap.del(state.mode, lhs)
		end
	end

end

-- vim.keymap.set()
-- vim.api.nvim_get_keymap('n')
-- vim.api.nvim_get_keymap('n')

return M


