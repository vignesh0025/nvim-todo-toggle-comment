local ts = vim.treesitter

local utils = require('nvim-todo-toggle-comment.utils')
local defconfig = require('nvim-todo-toggle-comment.defconfig')
local ts_comment_node = require('nvim-todo-toggle-comment.ts_get_comment_node')

local M = {}

M.config = {}

M.test = function ()
	print(utils.add_label_to_comment("This is a comment", "/*%s*/", "TODO:"))
end

local function setup_commands()
	vim.api.nvim_create_user_command('TodoToggle',
	function (args)
		require('nvim-todo-toggle-comment').add_label_comment(args["args"])
	end
	, { nargs = '?'})
end

M.setup = function (config)
	M.config = defconfig.get_config(config);
	setup_commands()
	-- vim.print(M.config)
end

M.get_comment_node = function (bufnr)
	ts.get_parser(bufnr):parse()
	local current_node = vim.treesitter.get_node({ bufnr= bufnr })
	local comment_node = ts_comment_node.get_comment_node(current_node)

	return comment_node
end

M.preview_label_comment = function (bufnr, comment_node, label)
		local comment_text = ts.get_node_text(comment_node, bufnr)
		local start_row, start_col, end_row, end_col = ts.get_node_range(comment_node)

		local label_idx = utils.extract_label_from_comment(comment_text, M.config.labels)
		local raw_comment = utils.extract_comment_without_label(comment_text, "/%*(.+)%*/", M.config.labels[label_idx])
		local final_comment = utils.add_label_to_comment(raw_comment, "/*%s*/", label)

		return {final_comment, start_row, start_col, end_row, end_col}
	end

M.add_label_comment = function (label, bufnr)
	if label == '' then
		label = nil
	end

	local current_bufnr = bufnr or vim.fn.bufnr()
	local comment_node = M.get_comment_node(current_bufnr)

	if comment_node ~= nil then
		local ret = M.preview_label_comment(current_bufnr, comment_node, label)
		local final_comment, start_row, start_col, end_row, end_col = unpack(ret)
		vim.api.nvim_buf_set_text(current_bufnr, start_row, start_col, end_row, end_col, {final_comment})
	end
end


return M
