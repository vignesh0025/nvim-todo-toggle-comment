local ts = require'nvim-treesitter.ts_utils'

function i(arg)
	vim.print(arg)
end

local q = require'vim.treesitter'
local node = q.get_node();
if node == nil then
	error("No Treesitter parser found")
end

local token_str = "TODO:"

-- comment_string: full comment string
-- comment_extract_pattern: Extracts comment test from commant_string "(/%*)(.-)(%*/)" or "(//)(.-)"
local toggle_comment = function (comment_string, comment_extract_pattern, label_token)
	local token_extract_pattern = "(%s"..label_token.."%s)" -- <space>TODO:<space>
	local token_string = " "..label_token.. " "

	local start, _, comment_start_token, comment_text, comment_end_token = string.find(comment_string, comment_extract_pattern, 0)
	if start ~= nil then
		local final_comment_string = ""
		local start,_,raw_comment = string.find(comment_text, token_extract_pattern, 0)
		-- There is token in the comment already
		if start ~= nil then
			final_comment_string = comment_start_token..raw_comment..comment_end_token
		else -- There is no token in the comment string
			final_comment_string = comment_start_token..token_string..raw_comment..comment_end_token
		end
		local lines = {}
		for s in res:gmatch("[^\r\n]+") do
			table.insert(lines, s)
		end
		return lines
	else
		error("Can't extract comment_text with "..comment_extract_pattern.." from "..comment_string)
	end
end

if node:type() == "comment" then
	-- ts.update_selection(0, node)
	local comment_string = q.get_node_text(node, 0)
	local start_row, start_col, end_row, end_col = q.get_node_range(node)
	-- 3rd param: start from position 0
	-- 4th param: plain text search, don't use reg exp in pattern
	local s, _ = string.find(comment_string, "/%*(.-)%*/", 0)
	if s ~= nil then
		-- Its a block comment
		local s, _ = string.find(comment_string, token_str)
		if s ~= nil then
			res = string.gsub(comment_string, "/%*(%s"..token_str.."%s)(.-)%*/", "/*%2*/")
		else
			res = string.gsub(comment_string, "/%*(.-)%*/", "/* "..token_str.." %1*/")
		end
		local lines = {}
		for s in res:gmatch("[^\r\n]+") do
			table.insert(lines, s)
		end
		vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, lines)
	end

	local s, _ = string.find(comment_string, "//(.-)", 0)
	if s ~= nil then
		-- Its a block comment
		local s, _ = string.find(comment_string, token_str)
		if s ~= nil then
			res = string.gsub(comment_string, "//(%s"..token_str.."%s)(.-)", "//%2")
		else
			res = string.gsub(comment_string, "//(.-)", "// "..token_str.." %1")
		end
		vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, {res})
	end

	-- vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, {"/* Summa Comment */"})
end

-- print(vim.inspect(getmetatable(node)))
-- print(node:type())
-- print(n:sexpr())
-- print(n:start())
-- ts.update_selection(0, node)
-- print(q.get_node_text(node, 0))

-- local language_tree = vim.treesitter.get_parser(bufnr, 'c')
local language_tree = vim.treesitter.get_parser()
local syntax_tree = language_tree:parse()
local root = syntax_tree[1]:root()

local query = vim.treesitter.query.parse('c', [[
	((comment) @comment)
]])

-- i(query)

for _, captures, metadata in query:iter_matches(root, bufnr) do
	-- print("RDR")
	-- print(vim.inspect(getmetatable(vim.inspect(captures[1]))))
--[[ 	i(captures[2])
	i(q.get_node_text(captures[2], bufnr)) ]]
end
