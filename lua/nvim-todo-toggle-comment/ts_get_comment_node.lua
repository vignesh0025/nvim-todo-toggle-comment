local M = {}
local ts = vim.treesitter

-- [[
-- This below can be used to acquire the entire langauge tree for full source code

-- Get the parser for the current buffer with the filetype of the buffer. Create a parser if not already available
-- We can give the buffer number and then manually give the language name if we want to use some other parser
-- local parser: vim.treesitter.LanguageTree = ts.get_parser(0)
-- INFO: vim.treesitter.get_text_parser() can be used to parse the given text with given source code string in unit tests

-- Once we have the parser, use parse() to start parsing the buffer to AST and return the tree
-- Returns a (number(what is that number?) & TSTree) so we put [1] to get the tree
-- local tree: TSTree = parser:parse()[1]

-- Returns the root of the tree and returns TSNode
-- local root: TSNode = tree[1]:root()

-- To extract text and range of the from the node =
-- vim.treesitter.get_node_text(node) and get_node_range(node)

-- ]]


-- [[
-- This is used to get the current node under the cursor
-- vim.treesitter.get_node()
--
-- Make sure vim.treesitter.get_parser(0):parse() is called before calling above
-- ]]

local get_comment_node = function (current_node)
	-- vim.treesitter.get_parser(0):parse()
	-- local current_node = vim.treesitter.get_node()
	if current_node ~= nil then
		if current_node:type() == "comment" then
			-- vim.print(vim.treesitter.get_node_text(current_node, 0))
			return current_node
		elseif current_node:type() == "comment_content" then -- Applicable for lua
			current_node = current_node:parent()
			if current_node ~= nil then
				-- vim.print(vim.treesitter.get_node_text(current_node, 0))
				return current_node
			end
		else
			-- vim.print("Not found")
			return nil
		end
	else
		error("Treeesitter not available for current buffer")
	end
end

M.get_comment_node = get_comment_node

-- comment
return M
