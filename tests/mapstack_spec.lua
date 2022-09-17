local function find_map(mapping, lhs)
	for _, map in ipairs(mapping) do
		if map.lhs == lhs then
			return map
		end
	end
end
describe("mapstack", function ()
	before_each(function ()
		pcall(vim.keymap.del,"n", "asdf")
		require("stackmap")._stack = {}
	end)

	it("can be required", function ()
		require("stackmap")
	end)

	it("can push a single map", function ()
		local rhs = "echo Hello"
		require("stackmap").push("abcd", "n", {
			["asdf"] = rhs,
		})

		local current_mapping = vim.api.nvim_get_keymap("n")
		local found = find_map(current_mapping, "asdf")
		assert.are_same(rhs, found.rhs)
	end)

it("can push a multiple map", function ()
		local rhs = "echo Hello"
		require("stackmap").push("abcd", "n", {
			["asdf"] = rhs,
			["asdf1"] = rhs,
		})

		local current_mapping = vim.api.nvim_get_keymap("n")
		local found = find_map(current_mapping, "asdf")
		assert.are_same(rhs, found.rhs)
	end)
	it("can delete mapping after pop : no original mapping", function ()
		local rhs = "echo Hello"
		require("stackmap").push("abcd", "n", {
			["asdf"] = rhs,
		})

		require("stackmap").pop("abcd")
		local current_mapping = vim.api.nvim_get_keymap("n")
		local found = find_map(current_mapping, "asdf")
		assert.are_same(nil, found)
	end)

	it("can delete mapping after pop : yes original mapping", function ()
		vim.keymap.set("n", "asdf", "echo 'OGG mapping'")
		local rhs = "echo Hello"
		require("stackmap").push("abcd", "n", {
			["asdf"] = rhs,
		})

		require("stackmap").pop("abcd")
		local current_mapping = vim.api.nvim_get_keymap("n")
		local found = find_map(current_mapping, "asdf")
		assert.are_same("echo 'OGG mapping'", found.rhs)
	end)

	it("does nothing when pop desn't exist", function ()

		require("stackmap").pop("abcd")
		local current_mapping = vim.api.nvim_get_keymap("n")
		local found = find_map(current_mapping, "asdf")
		assert.are_same(nil, found)
	end)
end)

