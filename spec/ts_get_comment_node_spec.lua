local mod = require('lua.nvim-todo-toggle-comment.ts_get_comment_node')

local M = {}

describe("Busted Unit Test: ", function()
	describe("ts_get_comment_node_spec: ", function()

		it("WIP: Default case", function()
			pending("Should implement test for extracting comment from node")

			local lua_sample = ""

			-- vim.treesitter.get_parser(0):parse()
			-- local current_node = vim.treesitter.get_node()
			local parser = vim.treesitter.get_string_parser(lua_sample, "lua")
			if parser ~= nil then
				-- local tree = parser:parse()[1]
				-- local node = parser:parse()[1]:root()
				-- vim.print("yes parser")
				-- vim.print(getmetatable(node))
				-- vim.print(node:sexpr())
			else
				vim.print("No parser")
			end
		end)
	end)
end)

return M
